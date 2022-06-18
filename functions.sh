function progress_bar {
    local numerator=$1
    local denominator=$2
    local length=$3
    local marks=$(( (2 * $numerator * $length + $denominator) / (2 * $denominator) ))
    local blanks=$(( $length - $marks ))
    for i in $(seq 1 $marks)
        do echo -n █
    done
    if (( $blanks > 0 ))
        then for i in $(seq 1 $blanks)
            do echo -n ━
        done
    fi
}

function pregnency_progress {
    local americanDateFormat=0  # set to 1 for day/month/year output

    local lastPeriod=$1
    local lastPeriodSec=$(date --date $lastPeriod +%s)
    local nowSec=$(date +%s)

    local pregnancyDays=$(( ($nowSec - $lastPeriodSec ) / 86400 ))
    local pregnancyWeeks=$(( $pregnancyDays / 7 ))
    local pregnancyDayOfWeek=$(( $pregnancyDays % 7 ))
    echo -n "We're "
    echo -n "$pregnancyWeeks weeks "
    if (( $pregnancyDayOfWeek ))
        then echo -n "$pregnancyDayOfWeek days "
    fi
    echo "along"
    echo

    local estimatedConceptionSec=$(date --date "$lastPeriod +14 days" +%s)
    local estimatedDueSec=$(date --date "$lastPeriod +40 weeks" +%s)
    echo "💦   $(progress_bar $(( $nowSec - $estimatedConceptionSec )) $(( $estimatedDueSec - $estimatedConceptionSec )) 20 )  👶"

    local dateFormat="+%-d/%-m/%Y"
    if (( $americanDateFormat ))
        then dateFormat="+%-m/%-d/%Y"
    fi
    local estimatedDueDate=$(date --date "$lastPeriod +40 weeks" $dateFormat)
    echo "Estimated due date: $estimatedDueDate"
}

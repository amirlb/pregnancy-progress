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
    local isGnuDate=$( date --version 2>/dev/null | grep -c "GNU coreutils" )
    local americanDateFormat=0  # set to 1 for day/month/year output

    local lastPeriod=$1
    local lastPeriodSec
    if (( $isGnuDate ))
        then lastPeriodSec=$(date --date $lastPeriod +%s)
        else lastPeriodSec=$(date -j -f %Y-%m-%d-%H-%M-%S $lastPeriod-00-00-00 +%s)
    fi
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

    local estimatedConceptionSec=$(( $lastPeriodSec + 86400 * 7 * 2 ))
    local estimatedDueSec=$(( $lastPeriodSec + 86400 * 7 * 40 ))
    echo "💦   $(progress_bar $(( $nowSec - $estimatedConceptionSec )) $(( $estimatedDueSec - $estimatedConceptionSec )) 20 )  👶"

    local dateFormat="+%-d/%-m/%Y"
    if (( $americanDateFormat ))
        then dateFormat="+%-m/%-d/%Y"
    fi
    local estimatedDueDate
    if (( $isGnuDate ))
        then estimatedDueDate=$(date --date "$lastPeriod +40 weeks" $dateFormat)
        else estimatedDueDate=$(date -j -f %s $lastPeriodSec $dateFormat)
    fi
    echo "Estimated due date: $estimatedDueDate"
}

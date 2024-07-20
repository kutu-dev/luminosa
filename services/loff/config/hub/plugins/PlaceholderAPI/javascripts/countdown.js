function main() {
    var now = new Date();
    var nextMonth = new Date(now.getFullYear(), now.getMonth() + 1, 1);
    
    var secondsLeft = (nextMonth.getTime() - now.getTime()) / 1000;

    var daysLeft = Math.round(
      secondsLeft / (24 * 60 * 60)
    )

    secondsLeft = secondsLeft % (24 * 60 * 60);

    var hoursLeft = Math.round(
      secondsLeft / (60 * 60)
    )

    secondsLeft = secondsLeft % (60 * 60);

    var minutesLeft = Math.round(
      secondsLeft / 60
    )

    secondsLeft = Math.round(secondsLeft % 60);

    return daysLeft + "d " + hoursLeft + "h " + minutesLeft + "m " + secondsLeft + "s";
}

main();

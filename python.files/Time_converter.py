def convert_minutes(minutes):
    hours = minutes // 60
    remaining = minutes % 60

    if hours > 0:
        return f"{hours} hr{'s' if hours > 1 else ''} {remaining} minute{'s' if remaining != 1 else ''}"
    return f"{remaining} minutes"


print(convert_minutes(130))
print(convert_minutes(110))
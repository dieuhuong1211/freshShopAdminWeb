import moment from "moment";
export default function formatTime(str) {
    return moment(str).format('LLL');
}


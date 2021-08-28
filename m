Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E453FA603
	for <lists+linux-can@lfdr.de>; Sat, 28 Aug 2021 15:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhH1NVQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 28 Aug 2021 09:21:16 -0400
Received: from mail-eopbgr80139.outbound.protection.outlook.com ([40.107.8.139]:56226
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234335AbhH1NVP (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Sat, 28 Aug 2021 09:21:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZGjUSgq/JqTzL4zejJ3cX7ngX2baQWZ5qlLjqzRmDw8+mhxIoFLAYmCAWe43cC+0vEAij55RxxHky4gepj5FxEXawY03atgHl642yxxheF5DvbT5fU0pod33BlJSE9Q8yKxeOSV/BAynWfdw1/l7TfWDjzuHaGhVJQ3+gV0ftBBtqik+eA9QUP5aY0hcG1huv+cooMTFJ+W4iONMDv5wK1QF9MRdUXEk5KRw34sGW5FauefNvGh59iwozbQLamwswBVfMbBlrse3hBzUFZCdIc+6cJPtfyfxK1gxuJoxWWtojGSF0pqAqbnERLGPVkGaOJHXXXIAl8PidXKj7pVXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Nz5je8HfkBmiV6QcRGfIaGOeqSgChYtVO1AbtRlRoA=;
 b=nN2bxE0V0Qe72gmOJVm5rNZY3BHusKdL2jLoP+87RqgGu+t4IJETfm1MhndS7VJt4w7O0e2C1N0tmyAIG505/yUsgXmlkX4+41CSC1BtDkY1I66sMP042An6mwcnlW/Zz3YC52MMrR5aD3M68Lsa779RfDdBnpIhUzCUDdNM4yEtiFIR5sJIDhtvD5WlCkPaVARwnDUowlNEoJHj2fbzzlm8T08w6Vb6YYTNmSIjHFbi/kE7VcaSlLHjuy5pmKx3wLCRDNPFDru7iJowqdQh9vRwLLjjbswDTjcKCrCw2e4LLv2CJLD2xh4oIxEacXumRA3CoROR9AwmIQqGZnO2PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=schleissheimer.de; dmarc=pass action=none
 header.from=schleissheimer.de; dkim=pass header.d=schleissheimer.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schleissheimer.onmicrosoft.com; s=selector1-schleissheimer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Nz5je8HfkBmiV6QcRGfIaGOeqSgChYtVO1AbtRlRoA=;
 b=CCoLVJQ3eKcJIJbaYg3rbpZKGj3zYosiXYDByVx1TdxovSuuWgaBZZUMVQTTxolHSN7Kb76qYV+k1oLBjiAbBUjtGgQYVFbHParcqiy5fBbnZw9kfpkR1LTp7G/cc6nqtER2a+FWIwgVvYwLZAl+pKE8koPhhZ13TmHdk83jErY=
Received: from DB8P190MB0634.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:12d::21)
 by DBAP190MB0952.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:1ab::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Sat, 28 Aug
 2021 13:20:22 +0000
Received: from DB8P190MB0634.EURP190.PROD.OUTLOOK.COM
 ([fe80::396d:bf7c:32d7:426]) by DB8P190MB0634.EURP190.PROD.OUTLOOK.COM
 ([fe80::396d:bf7c:32d7:426%6]) with mapi id 15.20.4457.023; Sat, 28 Aug 2021
 13:20:22 +0000
From:   Sven Schuchmann <schuchmann@schleissheimer.de>
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     Marc Kleine-Budde <mkl@pengutronix.de>
Subject: AW: [PATCH] can: isotp: omit unintended hrtimer restart on socket
 release
Thread-Topic: [PATCH] can: isotp: omit unintended hrtimer restart on socket
 release
Thread-Index: AQHXZGiarGqUjPpuCESr46IsZOKw9auJVcCA
Date:   Sat, 28 Aug 2021 13:20:22 +0000
Message-ID: <DB8P190MB06343614CAD6B48C3EA0EF00D9C99@DB8P190MB0634.EURP190.PROD.OUTLOOK.COM>
References: <20210618173713.2296-1-socketcan@hartkopp.net>
In-Reply-To: <20210618173713.2296-1-socketcan@hartkopp.net>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hartkopp.net; dkim=none (message not signed)
 header.d=none;hartkopp.net; dmarc=none action=none
 header.from=schleissheimer.de;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c02885a-affb-4d97-dbb7-08d96a2696eb
x-ms-traffictypediagnostic: DBAP190MB0952:
x-microsoft-antispam-prvs: <DBAP190MB09528F559F72642B8C74BBF0D9C99@DBAP190MB0952.EURP190.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:1201;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iLxUiimDMsCN+Q9OKdRwXz3QJPUJ5uabOjDksBAA3BI2RHVY7JgH7Mz0o0Pj/ybT/cb0IR6iYNiGR7/htRlvV7nSqxhfO0uoNeUUOiR1L5u083f8ag7jw3kjdX7C8tT6fboZT7XN69X5NdTSzy5ftFRISI8JN8aZR0P3SVfsFlKXsugTEOBBzfaSAd9miJqNiFcjJl8I+rZFq7zdDHol2FbxJHRqklgOH+zUdM6EvRv8OJxyPP7hY7EkMgWuDgv/Vurp83P7w6mxgJjER9pzaUdmlhNm/txsMhm/gEreLJcSKMkvtqdiiAGvShpbz9eVvqATaDO7nDuT/W1LIigCdaTQMRa/BFnN8DCuWEdUx5BCOKUqOcqWq4d9bQHrF8lKq4aM+QujpDUgRcfCfC7FPDrYy5TV5KkOskNYK0+jD+Jk8e0qNQ/wOiyLvjrr5ffSEibJwVWhpi7YpCAXLNR9Bwey81Ggul0Ose8DJNHeopzj8SiMO8Kh1WUlE3t+gSd34BTuMVrTrGcMvS6S+z2a1YkIocQDpPy26doOfDOlGgCWcsR3t6N/ziAFc/2OaarDm/LC4gLStUynOkLAiYdvKBj/iarQgmarUwtDPhCNsd/qFTAg43qqaJGO4EooZxOVWMbrLQg7Ix+q1kb07uGI31SUvKLeyhGLweFs6MFdDlEPxTfz0Ei1tEgXkBEQXj8IqWYjrqmHeGdtppcqdUBGLw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8P190MB0634.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39830400003)(136003)(396003)(376002)(346002)(366004)(9686003)(110136005)(508600001)(5660300002)(55016002)(4326008)(86362001)(316002)(66574015)(64756008)(38070700005)(66556008)(66446008)(8676002)(52536014)(83380400001)(76116006)(66946007)(66476007)(71200400001)(33656002)(6506007)(186003)(7696005)(38100700002)(2906002)(26005)(122000001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1X6akAFmQQ0oaMuRwchjqv9ueAGRbCnQOtTc2klSOSrQpHCkcidm0rMZ2C?=
 =?iso-8859-1?Q?TbgEQ9U6O3SWu2Gz5IitcwuMLn2k6JlhzNRE5pHSscjCeOvOYFtIbmigxS?=
 =?iso-8859-1?Q?y0bUUMzc87C9kk4EYpiePQBW+AxJiLQp+DbF4GwGeoNeW0MIRPnP0YHzuu?=
 =?iso-8859-1?Q?6GlBgZFxuK9IRr6uJ1uTybFg5/RS17CQTyp0RT2S3ZAQbZjGQjRKbLEueR?=
 =?iso-8859-1?Q?IkutmFwt8iQ6kriwBkLyshsYh83kAysFo6ecXnx8yIIw0RHb3/BXDM0lXh?=
 =?iso-8859-1?Q?4OOiS3fwywp3VOYn2kvn7USosEeZfdd+WVwgCkjM3kWKlNg0vFnHwDL0I3?=
 =?iso-8859-1?Q?CkR1HqIQAikJxygb6w63CvRLrJLhVlAEXeIfSfVLXrPf5iUVgnVI0IIB/N?=
 =?iso-8859-1?Q?wW2leMWNGU0HIBfpV1SeAbs3KWAIDjVM/tfO78lc6HsP+gody85r27A+Rt?=
 =?iso-8859-1?Q?NlVHG8LktRskGSZKeyIeBAgAKr0+s1e0W9XRPkWX9YYVpXP0aUDaJl1rmG?=
 =?iso-8859-1?Q?DdzOhxIb9fX2TRLn9ayxz2m2PvylSzNQ9910sRDg/oar0TqcG+LowUXQJs?=
 =?iso-8859-1?Q?oP0Je+VogqoMCp9wr+g6RXJl8bZHgCLVlUH+mjteQV+qSNLEKkE6/9Djjz?=
 =?iso-8859-1?Q?xvpG+VLhyexSp95vnT5j8otQXKhh6fN2KTns0rgKaEy/hb405WZNREkVrx?=
 =?iso-8859-1?Q?cMzaGeU8PPIIcjeRFzzywY+PT/UYmpOr+3U+WFQN9qSmcjyLGwpm7yJV1y?=
 =?iso-8859-1?Q?Nzr1SSWsBz4LVWSKnpfxSei0Xki0WKw7xDajVGeJObHHOaL8p18OiNtmfw?=
 =?iso-8859-1?Q?G5a7ofmtAjN5t9smyv5NZcoSHrtRVOX7OD6l2nFgXBVyfR8woNzuVPn93S?=
 =?iso-8859-1?Q?LLtbxqad+H6Fnr2MsoupQoBCdrtObKvs0OIjfGbbixERJ1rwuxd5fszzWF?=
 =?iso-8859-1?Q?0UbrlK0R0ENhQvwkP5+aB9Y9Tl7QPsVE7xgiXuLvJj2+TkdSHiAt7UDMD+?=
 =?iso-8859-1?Q?iX/J4GenKgQNKl3bO42R7zvAi7C9oF5yBdsgHHOUdF2wPW+dMjCSrXpDeZ?=
 =?iso-8859-1?Q?E//INPuvrcfUAkICQmi+wl1tDRo5e4lPhLRGzEgfU8FE+L/f+QZ5WEeEZL?=
 =?iso-8859-1?Q?BpqB2KPbLWp5MSPvAigzpDXr3TyLRR8WHmKIEsW59qHt509hDR8a3QrObs?=
 =?iso-8859-1?Q?Ys2+Tf4TrnQvLE30RA0z2lEqnx3dOc2DsAmC0azB37OjdOT4wFd2dViA2h?=
 =?iso-8859-1?Q?OKamCdqSlI3StCGYfIMp1hB/G3NDtCUvku40L4Bud+ehqShQqyIRKwFfZ0?=
 =?iso-8859-1?Q?QOfa8rMkoKJa5eez03QcrA2um3Md7i89o0NTfdR8JGhHjz0qUulbayXNY+?=
 =?iso-8859-1?Q?4XzY3E5l5Z?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: schleissheimer.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8P190MB0634.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c02885a-affb-4d97-dbb7-08d96a2696eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2021 13:20:22.1115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ba05321a-a007-44df-8805-c7e62d5887b5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NgkJxZgyHNovmQxr8G+P25vLG3JuBE7jin7nxzEYZ/K9/OG00WUIhyCFKWOihWxEL5XwuJ5uvkDwDXLQw5Pd1XG4NjiVRqxuzmkQhLaCyns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP190MB0952
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,
sorry, I'm late for the party :-)=20
But I found that this patch decreases the performance of ISO-TP Stack.

I have created two testscripts where one plays the server and the=20
other one is running a test and measuring the time how long
it takes to transfer an ISO-TP Frame with 1000 Bytes.

Without this patch it takes about 35ms to transfer the frame,
with this patch it takes about 145ms over vcan0.

Anyone an idea on this?

Sven


bring up a vcan0 interface with:
sudo modprobe vcan
sudo ip link add dev vcan0 type vcan
sudo ifconfig vcan0 up

here are the scripts:
--- isotp_server.sh ---
#!/bin/bash
iface=3Dvcan0
echo "Wait for Messages on $iface"
while true; do
    exec 3< <(isotprecv -s 77E -d 714 -b F -p AA:AA $iface)
    rxpid=3D$!
    wait $rxpid
    output=3D$(cat <&3)
    echo "7F 01 11" | isotpsend -s 77E -d 714 -p AA:AA -L 16:8:0 $iface
done

--- isotp_test.sh ---
#!/bin/bash
databyte=3D01
numbytes=3D1000
iface=3Dvcan0
echo "Test iso-tp with $numbytes byte frames on $iface (data:$databyte)"
message=3D"01 " # invalid service 01
for (( i=3D1; i<=3D$numbytes; i++ ))
do
   message=3D"$message$databyte "
done
i=3D1
timemin=3D10000
timemax=3D0
timesum=3D0
while true; do
    ts=3D$(date +%s%N)
    exec 3< <(isotprecv -s 714 -d 77E -b 5 $iface)
    rxpid=3D$!
    echo $message | isotpsend -s 714 -d 77E -p AA:AA -L 16:8:0 $iface
    wait $rxpid
    output=3D$(cat <&3)
    timediff=3D$((($(date +%s%N) - $ts)/1000000))
    if [ "7F 01 11 " !=3D "$output" ]; then
        echo "ERROR: $i >$output<"
        break
    fi
    if [ $timediff -gt $timemax ]; then
        timemax=3D$timediff
    fi
    if [ $timediff -lt $timemin ]; then
        timemin=3D$timediff
    fi
    ((timesum=3Dtimesum+timediff))
    timeavg=3D$(echo "$timesum / $i" | bc -l)
    printf "%5d / curr:%5d / min:%5d / max:%5d / avg:%7.1f\n" $i $timediff =
$timemin $timemax $timeavg
    ((i=3Di+1))
done
------

Sven Schuchmann
Schlei=DFheimer Soft- und
Hardwareentwicklung GmbH
Am Kalkofen 10
61206 Nieder-W=F6llstadt
GERMANY
Phone: +49 6034 9148 711
Fax: +49 6034 9148 91
Email: schuchmann@schleissheimer.de

Court of Registration: Amtsgericht Friedberg
Registration Number: HRB 1581
Management Board:
Hans-Joachim Schlei=DFheimer
Christine Schlei=DFheimer

> -----Urspr=FCngliche Nachricht-----
> Von: Oliver Hartkopp <socketcan@hartkopp.net>
> Gesendet: Freitag, 18. Juni 2021 19:37
> An: linux-can@vger.kernel.org
> Cc: Oliver Hartkopp <socketcan@hartkopp.net>
> Betreff: [PATCH] can: isotp: omit unintended hrtimer restart on socket re=
lease
>=20
> When closing the isotp socket the potentially running hrtimers are
> canceled before removing the subscription for CAN idendifiers via
> can_rx_unregister().
>=20
> This may lead to an unintended (re)start of a hrtimer in isotp_rcv_cf()
> and isotp_rcv_fc() in the case that a CAN frame is received by
> isotp_rcv() while the subscription removal is processed.
>=20
> However, isotp_rcv() is called under RCU protection, so after calling
> can_rx_unregister, we may call synchronize_rcu in order to wait for any
> RCU read-side critical sections to finish. This prevents the reception
> of CAN frames after hrtimer_cancel() and therefore the unintended
> (re)start of the hrtimers.
>=20
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  net/can/isotp.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index be6183f8ca11..234cc4ad179a 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -1026,13 +1026,10 @@ static int isotp_release(struct socket *sock)
>  	list_del(&so->notifier);
>  	spin_unlock(&isotp_notifier_lock);
>=20
>  	lock_sock(sk);
>=20
> -	hrtimer_cancel(&so->txtimer);
> -	hrtimer_cancel(&so->rxtimer);
> -
>  	/* remove current filters & unregister */
>  	if (so->bound && (!(so->opt.flags & CAN_ISOTP_SF_BROADCAST))) {
>  		if (so->ifindex) {
>  			struct net_device *dev;
>=20
> @@ -1040,14 +1037,18 @@ static int isotp_release(struct socket *sock)
>  			if (dev) {
>  				can_rx_unregister(net, dev, so->rxid,
>  						  SINGLE_MASK(so->rxid),
>  						  isotp_rcv, sk);
>  				dev_put(dev);
> +				synchronize_rcu();
>  			}
>  		}
>  	}
>=20
> +	hrtimer_cancel(&so->txtimer);
> +	hrtimer_cancel(&so->rxtimer);
> +
>  	so->ifindex =3D 0;
>  	so->bound =3D 0;
>=20
>  	sock_orphan(sk);
>  	sock->sk =3D NULL;
> --
> 2.30.2


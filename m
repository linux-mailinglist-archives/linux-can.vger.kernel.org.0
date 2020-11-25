Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9DC52C3C41
	for <lists+linux-can@lfdr.de>; Wed, 25 Nov 2020 10:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgKYJfg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 25 Nov 2020 04:35:36 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:64724 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbgKYJff (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 25 Nov 2020 04:35:35 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20201125093532epoutp03941c6ae615bc77fb9042ac78db9adb45~Ktoy8dgPX2347623476epoutp03T
        for <linux-can@vger.kernel.org>; Wed, 25 Nov 2020 09:35:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20201125093532epoutp03941c6ae615bc77fb9042ac78db9adb45~Ktoy8dgPX2347623476epoutp03T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1606296932;
        bh=n9biWExjvNSgHjOtRLD9LLhzcVWLNwjj2dRgYcRfsZg=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=XPhBxgHVVGUNf8LISV4F6SwrgNOByETKdI3QUSUDInz6nYtKoYJcsKHdtuVuY3Uzk
         8y3sYzlqDLneUkjEeA8PAtOS0Olfuuxh6/iwVXdRQhGWcO8NGMmMQyPkob4Gu1dX/X
         +ifWEcyZfVv6ET7Y8uw6op/VjL0YZGa73bmGe6As=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20201125093532epcas5p169198c33afeeafc3d487a7ace816dc1f~KtoympJ7D0893008930epcas5p1A;
        Wed, 25 Nov 2020 09:35:32 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C6.D7.50652.4652EBF5; Wed, 25 Nov 2020 18:35:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20201125085602epcas5p45dfae2c9409215b9dfe82f34da088ffd~KtGTMc1Qu3172931729epcas5p4j;
        Wed, 25 Nov 2020 08:56:02 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201125085602epsmtrp1fa5aa2cf2278f43cb44a871852012d5f~KtGTLykLw1205412054epsmtrp1N;
        Wed, 25 Nov 2020 08:56:02 +0000 (GMT)
X-AuditID: b6c32a4a-6b3ff7000000c5dc-9c-5fbe2564b9d3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        70.74.13470.12C1EBF5; Wed, 25 Nov 2020 17:56:02 +0900 (KST)
Received: from sriramdash03 (unknown [107.122.1.249]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201125085601epsmtip147ca885094863122efe3a9333debd9bd~KtGSTkSu-0433104331epsmtip14;
        Wed, 25 Nov 2020 08:56:01 +0000 (GMT)
From:   "Sriram Dash" <sriram.dash@samsung.com>
To:     "'Marc Kleine-Budde'" <mkl@pengutronix.de>,
        <linux-can@vger.kernel.org>
Cc:     "'Dan Murphy'" <dmurphy@ti.com>,
        "'Mario Huettel'" <mario.huettel@gmx.net>,
        "'Quentin Schulz'" <quentin.schulz@free-electrons.com>
In-Reply-To: <20201124190751.3972238-1-mkl@pengutronix.de>
Subject: RE: [net] can: m_can: fix nominal bitiming tseg2 min for version >=
 3.1
Date:   Wed, 25 Nov 2020 14:25:59 +0530
Message-ID: <012701d6c308$ccec20f0$66c462d0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-in
Thread-Index: AQLdPHNcRo7BzMFX49/cNVbKXbp36AHfFMwXp7yexpA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsWy7bCmhm6K6r54gzmbeCy6T29htVj1fSqz
        xYU1O5ks1i+awmKxZNJjZgdWjyebLjJ6LN60n82j/6+Bx/Eb25k8Pm+SC2CN4rJJSc3JLEst
        0rdL4Mpo2vGOvWAeT0XfoytsDYwfObsYOTkkBEwkrm24zN7FyMUhJLCbUWL2gb1MEM4nRomr
        f+9DOd8YJXbc62GCaTk/7zMLRGIvo8TSngNQzitGidOnzrGCVLEJ6EqcvdHE1sXIwSEi4C3R
        /EcdpIZZoItR4sL97ewgNZwCVhK3Tu5jAbGFBYIk2rc/AOtlEVCVmHepgRmkl1fAUmJRvyZI
        mFdAUOLkzCdg5cwC8hLb385hhjhIQeLn02WsEHFxiaM/e5gh1lpJPPkJdpqEQCuHxPfv06Ae
        cJFYfWsOI4QtLPHq+BZ2CFtK4mV/G5SdLXG57znU/BKJGa8WskDY9hIHrsxhAZnPLKApsX6X
        PkRYVmLqqXVMECfwSfT+fgK1ildixzwYW1Xi1e3NUOOlJQ6sPc00gVFpFpLPZiH5bBaSb2Yh
        bFvAyLKKUTK1oDg3PbXYtMAoL7Vcrzgxt7g0L10vOT93EyM44Wh57WB8+OCD3iFGJg7GQ4wS
        HMxKIrzuwnvjhXhTEiurUovy44tKc1KLDzFKc7AoifMq/TgTJySQnliSmp2aWpBaBJNl4uCU
        amByDbmw/Nu5Vcqcz7M5S3kL5aQ0ujo1U649XnirzvDQNq+cSa4t7dnvta+tnvDhZM8v699e
        TTtjsjZ91UqZLbTj1G4t3du/Q9wX6mTu0KyuVZubWVp38aXlWbOUQ9uu/L05V69odfnMfe5S
        ZabOO1Lz/0tfYuWO8PcK0c++vuhEdHyN3sXuxvNlM/R0bV7G19dve3pd4kbFx/3Mz1W7UrlO
        W/30fSUy69ZPGe6V0g25jaZX9iUclvMv/3F/jiLbHP5ZvoyHtnX/cFMSbj79XbLV+Mdtj9P2
        cTrXV0x4p9US/4Brkkn01IcHXmxi0Lq8VmbW1RQF1Rg9ue4WaysGpwV+TZpzz3rXzuifctl0
        tq8SS3FGoqEWc1FxIgAoeZnqpwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsWy7bCSnK6SzL54g483GC26T29htVj1fSqz
        xYU1O5ks1i+awmKxZNJjZgdWjyebLjJ6LN60n82j/6+Bx/Eb25k8Pm+SC2CN4rJJSc3JLEst
        0rdL4Mpo2vGOvWAeT0XfoytsDYwfObsYOTkkBEwkzs/7zNLFyMUhJLCbUaLnyhwghwMoIS3x
        864uRI2wxMp/z9khal4wSjTtvsgIkmAT0JU4e6OJDcQWEfCVON/TwwxSxCzQxSjxa8YDNoiO
        biBn7jR2kCpOASuJWyf3gW0QFgiQ2LcHrJlFQFVi3qUGZpAwr4ClxKJ+TZAwr4CgxMmZT8Cq
        mQX0JNo2gq1lFpCX2P52DjPEbQoSP58uY4WIi0sc/dkDNkUEaNGTnywTGIVnIRk0C2HQLCSD
        ZiFpXsDIsopRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIzhitDR3MG5f9UHvECMTB+Mh
        RgkOZiURXnfhvfFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeW8ULowTEkhPLEnNTk0tSC2CyTJx
        cEo1MOU+CjuwxjFasV+wNnUx8+Ld84OP+D1VWKop5Cqle4+764q21VWFZzb+4paVSc1+6nU8
        3rvUOQXnOjdrO4d4zaqIsL6yOiDr6GmJbXml7+PTnuaklG/4l+4639qrRILPQLP041V/lUWs
        a47kC20My+o49P74Az+WIO4NP1M+unW56Mr8eHOxvL3tz/fPpS3fizRLj3rOcTe0/7dxxu45
        S8S8fu4sUvRRqZ3CdpWjLteaVWDVmn2xT3dxdHvq/Vzvut96g2TXjt03Hm2IXc9Y18Ut+KUp
        LMHc+dZBswtb5tpn7z/wvTzmA6OLg61i1O4Zjb7nZrDtntl8NOYhZ0rvfxYP956vgjPvr3pq
        VlipxFKckWioxVxUnAgAVCgBDwcDAAA=
X-CMS-MailID: 20201125085602epcas5p45dfae2c9409215b9dfe82f34da088ffd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20201124190800epcas5p4d5b22f8411d818ec422f24497e78328e
References: <CGME20201124190800epcas5p4d5b22f8411d818ec422f24497e78328e@epcas5p4.samsung.com>
        <20201124190751.3972238-1-mkl@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

> From: Marc Kleine-Budde <mkl@pengutronix.de>
> Subject: [net] can: m_can: fix nominal bitiming tseg2 min for version >=
3.1
> 
> At lest the revision 3.3.0 of the bosch m_can IP core specifies that valid
> register values for "Nominal Time segment after sample point (NTSEG2)" are
> from
> 1 to 127. As the hardware uses a value of one more than the programmed
> value, mean tseg2_min is 2.
> 
> This patch fixes the tseg2_min value accordingly.
>

Acked-by: Sriram Dash <sriram.dash@samsung.com>

> Cc: Dan Murphy <dmurphy@ti.com>
> Cc: Sriram Dash <sriram.dash@samsung.com>
> Cc: Mario Huettel <mario.huettel@gmx.net>
> Cc: Quentin Schulz <quentin.schulz@free-electrons.com>
> Fixes: b03cfc5bb0e1 ("can: m_can: Enable M_CAN version dependent
> initialization")
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/m_can/m_can.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/m_can/m_can.c
> b/drivers/net/can/m_can/m_can.c index f3fc37e96b08..86bbbfa2d743
> 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -1033,7 +1033,7 @@ static const struct can_bittiming_const
> m_can_bittiming_const_31X = {
>  	.name = KBUILD_MODNAME,
>  	.tseg1_min = 2,		/* Time segment 1 = prop_seg + phase_seg1
> */
>  	.tseg1_max = 256,
> -	.tseg2_min = 1,		/* Time segment 2 = phase_seg2 */
> +	.tseg2_min = 2,		/* Time segment 2 = phase_seg2 */
>  	.tseg2_max = 128,
>  	.sjw_max = 128,
>  	.brp_min = 1,
> --
> 2.29.2
> 



Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C3C2E95C9
	for <lists+linux-can@lfdr.de>; Mon,  4 Jan 2021 14:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbhADNWU (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 4 Jan 2021 08:22:20 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:48841 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbhADNWS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 4 Jan 2021 08:22:18 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210104132134epoutp025be596b3d4e964ef2e7592f634d66e0a~XChkOr5Ko2759727597epoutp02q
        for <linux-can@vger.kernel.org>; Mon,  4 Jan 2021 13:21:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210104132134epoutp025be596b3d4e964ef2e7592f634d66e0a~XChkOr5Ko2759727597epoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1609766494;
        bh=qwG/j1MHx/rjwSSqKo3StoXAwxtWZaTDQyXZEk/i8oQ=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=WEiX7j+6+IL4hhWpQud78htnHuTxv1RO5tFCWPB/0n+mqCcHxWBKCkYBlyCrCYL2c
         aReHlaGRRzZ+qlCpT2Yfb9X5d7XNnIgEfo0qXg3F13hWgwqVhV5cdGwFVd9BIPfBCd
         DSRnhDo8joccEHLbQanb9tVrr+vVbaBAPwdABFFg=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20210104132133epcas5p143c57181d2139fcb6aa51fa2a211c9c6~XChjnW_MF1178411784epcas5p1k;
        Mon,  4 Jan 2021 13:21:33 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        83.81.50652.D5613FF5; Mon,  4 Jan 2021 22:21:33 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20210104131306epcas5p169b135d79ee4576ed00735351982fead~XCaLfhcTb2442124421epcas5p1v;
        Mon,  4 Jan 2021 13:13:06 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210104131306epsmtrp24163279d19f869c7d8b29eb661c8656a~XCaLe34ga3247232472epsmtrp2u;
        Mon,  4 Jan 2021 13:13:06 +0000 (GMT)
X-AuditID: b6c32a4a-6c9ff7000000c5dc-35-5ff3165d3426
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        BC.75.08745.26413FF5; Mon,  4 Jan 2021 22:13:06 +0900 (KST)
Received: from pankjsharma02 (unknown [107.122.12.50]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210104131305epsmtip17800888b93c48b756eabf9a55f04b8ec~XCaKQcWVo2273822738epsmtip16;
        Mon,  4 Jan 2021 13:13:05 +0000 (GMT)
From:   "pankj.sharma" <pankj.sharma@samsung.com>
To:     "'Marc Kleine-Budde'" <mkl@pengutronix.de>,
        "'Sriram Dash'" <sriram.dash@samsung.com>,
        <linux-kernel@vger.kernel.org>
Cc:     <linux-can@vger.kernel.org>, <dmurphy@ti.com>,
        <pankaj.dubey@samsung.com>
In-Reply-To: <9b212ce7-51e6-f6a7-fa34-5a9118c56927@pengutronix.de>
Subject: RE: [PATCH] MAINTAINERS: Update MCAN MMIO device driver maintainer
Date:   Mon, 4 Jan 2021 18:43:04 +0530
Message-ID: <159001d6e29b$576344a0$0629cde0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJhQyIlwhM5RMBPM0HYr/vXunjykwIQwDY9AR7ZsHao6TMK0A==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7bCmpm6s2Od4g60fjCy6T29htVj1fSqz
        xeVdc9gs1i+awmKxaOsXdosb69kd2Dz6/xp49G1Zxehx/MZ2Jo/Pm+QCWKK4bFJSczLLUov0
        7RK4Mla+PMlccIS94nBLL3MD4w/WLkZODgkBE4lDa8+C2UICuxklzj036GLkArI/MUoc7p8J
        lfjMKNE33Qum4f6HbWwQRbsYJbY9mM8O4bxmlNi+7zk7SBWbgL7ElKa/LCC2iEC1RG/fU2YQ
        m1nAX+LJ/Q9gcU4BJ4ney5+ZQGxhAW+JyU3LGEFsFgEViXsnuoA2cHDwClhKPOkIBAnzCghK
        nJz5hAVijLbEsoWvmSEOUpD4+XQZK8QqJ4lDjzdB1YhLvDx6BOw2CYFGDonVazYzQTS4SKw/
        eoIdwhaWeHV8C5QtJfH53V42CDtbYuHufhaQGyQEKiTaZghDhO0lDlyZAxZmFtCUWL9LHyIs
        KzH11DomiLV8Er2/n0Bt4pXYMQ/GVpOY+vQdI4QtI3Hn0Wa2CYxKs5B8NgvJZ7OQfDALYdsC
        RpZVjJKpBcW56anFpgVGeanlesWJucWleel6yfm5mxjBqUbLawfjwwcf9A4xMnEwHmKU4GBW
        EuGtuPAhXog3JbGyKrUoP76oNCe1+BCjNAeLkjjvDoMH8UIC6YklqdmpqQWpRTBZJg5OqQam
        ZNVV3DEtEv1yp0y37ztf4qosXzG/2iRi2yIRg+fbpaddVO/KXLOavzZvrdXs0/Pdi+doXvyr
        cdN+isQJn5nWXBGrfvwKj7mQUb7A8/UXm6Y1X2/9vbx9zZ1DNgqch3UX+xSq2ObvYTC6tVEj
        izNRu9nD7s8yucIw9+tdbW19Omrblh/pWVjyP3Hjq1SfqdXhC/IfJk3SbL0Y1cR97MYc2W8v
        LrTav4zcwyB5Zz5XvA7T59iONQuj2md/EDoaypy8OXpa/CYG4T9rN127t2P36ZOGB2X+tzX2
        W4f8b72/WNB2j9gM3nmWBXeUct8F1WqZfuTYdJg5yLSCgZs51VXnlkiRlMXhsLqCfe+/rGlR
        YinOSDTUYi4qTgQAca1aQ6QDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsWy7bCSnG6SyOd4g09XjS26T29htVj1fSqz
        xeVdc9gs1i+awmKxaOsXdosb69kd2Dz6/xp49G1Zxehx/MZ2Jo/Pm+QCWKK4bFJSczLLUov0
        7RK4Mr4daGQqWMVecfZfJ2MD4z3WLkZODgkBE4n7H7axdTFycQgJ7GCUuLrgCnMXIwdQQkZi
        8edqiBphiZX/nrND1LwEqln5hQUkwSagLzGl6S+YLSJQK3Fl+y9mEJtZIFBi7s0XrBANRxgl
        Fh1dwg6S4BRwkui9/JkJxBYW8JaY3LSMEcRmEVCRuHeiiw1kMa+ApcSTjkCQMK+AoMTJmU9Y
        IGZqS/Q+bGWEsZctfM0McZyCxM+ny1ghbnCSOPR4E1S9uMTLo0fYJzAKz0IyahaSUbOQjJqF
        pGUBI8sqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS95PzcTYzgqNHS2sG4Z9UHvUOMTByMhxgl
        OJiVRHgrLnyIF+JNSaysSi3Kjy8qzUktPsQozcGiJM57oetkvJBAemJJanZqakFqEUyWiYNT
        qoEp1feW6InT5jGCWavPd186uO5IG+eE0NjkoBvVVveZZ8owT5zvn6cr46Qgdlr4kkVNzaUD
        Yq3t3U8mMyqrBf1epn1z86pv54QbUxN4sl8+0sl46VSZFOy1VS1A1HN9/Lv49G0XheX+F6pe
        4pizeeftva828xVzdGZMFmO39Y6LlZr88nNRqioX602hf82CDrmtGWf/vdYy/6/oU2ktEJHJ
        1N367PeRqRmFNoueb7dcUPgsrDDwTPr/i+y9VU5ZW9hN1gVZnaxoa3GwXj23TMDi37ZwL/st
        SdEH4is5uNaLev8QrHJpzmIWOM+/VzXh4+Ujtg4259xl0u82MnwPF7iUE/u5lMchbBLj9LfN
        SizFGYmGWsxFxYkAvqXbdgkDAAA=
X-CMS-MailID: 20210104131306epcas5p169b135d79ee4576ed00735351982fead
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210104122607epcas5p3d63c769007bad3cfe00ff0fce99e082c
References: <CGME20210104122607epcas5p3d63c769007bad3cfe00ff0fce99e082c@epcas5p3.samsung.com>
        <20210104123134.16930-1-sriram.dash@samsung.com>
        <9b212ce7-51e6-f6a7-fa34-5a9118c56927@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

> From: Marc Kleine-Budde <mkl=40pengutronix.de>
> Subject: Re: =5BPATCH=5D MAINTAINERS: Update MCAN MMIO device driver
> maintainer
>=20
> On 1/4/21 1:31 PM, Sriram Dash wrote:
> > Update Pankaj Sharma as maintainer for mcan mmio device driver as I
> > will be moving to a different role.

Acked-by: Pankaj Sharma <pankj.sharma=40samsung.com>

> >
> > Signed-off-by: Sriram Dash <sriram.dash=40samsung.com>
> > ---
>=20
> Applied to linux-can/testing.
>=20
> Tnx,
> Marc
>=20
> --
> Pengutronix e.K.                 =7C Marc Kleine-Budde           =7C
> Embedded Linux                   =7C https://protect2.fireeye.com/v1/url?=
k=3D8b005a7e-
> d49b6343-8b01d131-0cc47a31309a-1e7ada642c78a62f&q=3D1&e=3D7d13a30c-
> d7d8-4a74-aa6c-6beb64121cd7&u=3Dhttps%3A%2F%2Fwww.pengutronix.de%2F
> =7C
> Vertretung West/Dortmund         =7C Phone: +49-231-2826-924     =7C
> Amtsgericht Hildesheim, HRA 2686 =7C Fax:   +49-5121-206917-5555 =7C



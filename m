Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C8F2CFF27
	for <lists+linux-can@lfdr.de>; Sat,  5 Dec 2020 22:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbgLEVRW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 5 Dec 2020 16:17:22 -0500
Received: from mout.web.de ([212.227.17.12]:48297 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727457AbgLEVRW (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Sat, 5 Dec 2020 16:17:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1607202928;
        bh=gsMnfgTWPJMKy4+W+Q9U0oPInIqhzNp1B8BiDR28YF4=;
        h=X-UI-Sender-Class:From:To:References:In-Reply-To:Subject:Date;
        b=ie8ELeH4P/9UzlR1eaJ3JMEor2BaKcfmsg0X82TuSUPRnBGW3uXuWupdULQ4+jFdJ
         ICzd/HRFZlsVVf8MVJbHHXFf4nB9vyFzQZk3kMYG8d0m1Wj2vpN/CD+Ixch1S1E9KB
         xJ7VFAyf/5UorHH8TQonZQVN4TpM6PqytXGfGaCE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from THOMASPCWIN ([217.86.29.88]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M8iPI-1ktJro1PO0-00CCmL; Sat, 05
 Dec 2020 22:15:28 +0100
From:   <thwa1@web.de>
To:     "'Marc Kleine-Budde'" <mkl@pengutronix.de>,
        <socketcan@hartkopp.net>, <linux-can@vger.kernel.org>
References: <20201204135557.55599-1-thwa1@web.de> <df231f75-c163-14b3-7ecf-c7341608abec@pengutronix.de>
In-Reply-To: <df231f75-c163-14b3-7ecf-c7341608abec@pengutronix.de>
Subject: RE: [PATCH] isotp: do not validate RX address when the broadcast flag is active
Date:   Sat, 5 Dec 2020 22:15:28 +0100
Message-ID: <004101d6cb4b$c1e8bf10$45ba3d30$@web.de>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: de
Thread-Index: AQIg/L98+E5wVwXo1QmXRjRKpgJxCQIc2b1vqUO2AwA=
X-Provags-ID: V03:K1:+vmF+ekuO+gc5Oqwj28Sjl9UHWz2feWWUsNA4TatWRgpO3O1rIS
 w6wcwHwjL2w3TVZ2vYC8BQ+iVrNOejO0vfdqoWoxuhtqHjKxRnGliNfgDNcTXyXpYQ93LSb
 jr74SMrPLB/iFvZJmszQ191aPLbAcHXPzrWng1za08cduurdV1tkCeCvlq9652xZg/0FNk3
 0J8VM8rIT5anGrwU1aBzw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gI2nUx7UwXs=:uIEQ3k7gou2wLSOUFErOiV
 xJf07yoZkCU9/h9XeqLFHQmFXUZp1JsihfVLc61uOCnHL+w35271hvqyaaoMwJPd8AJCHLusb
 W5n7cAZYX4a8jm1rdVXOXT/zWlDImQ5C1htf6Q1e8SxC8zCV2pyLTfnqDy8o8pACbwBlDAO4c
 hWOu/kWkNSPH3v+B920uLUqP93iw9sJjmwAfYxIRvJcmIUyeCfXSu2TYimJzFSKFA++kMDxbD
 i4RO1UMYta/ausBjGz38uId4P7jgq5Flq3hCNxbxRdihCiB4q8MF+PVPeVNE+ZmvXKufxnCYu
 ruc9MH/FnBjesdcHXLdU0U0dDUe50Ynr+pZhd3Fh/H4uYNv1wsplGrOCp+69dUvuwzBXa9lCX
 Xu9SLCZDcckS+mTJwELxXYvlxBQtl+ZgfpG+zOZ1a7ZUmW6f5eDQWiTg3SeuRRINPuq1cVZvg
 4RXDhmjd+kSfrOZ9bD2cEt3ZaR6MaAq8C+gKPkTseGG8Qj7w9RhgbJZsgZdJ18jrS5TDuY2iJ
 eAL+7A74XoLM1OnWEI3zy2kDAkOQ4WzrY1NykqQ3mwPGKiCrk5P3KPg4Hc67lUhMs8qbo5C/R
 CeTcg7c0AwqCru+1P86K2XoyTyl3v08/i+T0vvgmgWavtPISoE8lu0fDag0rqUA1lkoMH/5+7
 K6X6SJ3K48ln/rMXwXguZO2q0SJJUeJKXh0BWiFejlrvNGsCauiZyFgfCl01+SIk/IqvQRX9j
 S+F+lKHO1Z52/qaZaRGWVRuBwuj+mQEcRX/ZXrx9cxHcXvRPht3XXDgLPB0BbA3mh53s1SMsZ
 YeGmRHEQYMAGsgLtlHr2S3p3SfXWnitht70b2laex3UsG9CoRPX4SpYo6cBNizW/1epe90/mZ
 UTq9IxF6btQrOMAK4yEg==
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

On 05.12.20 21:59, Marc Kleine-Budde wrote:
> On 12/4/20 2:55 PM, Thomseeen wrote:
> > EADDRNOTAVAIL shouldn't be thrown when an invalid RX address (e.g. NO_=
CAN_ID)
> > is set while the socket is used with the CAN_ISOTP_SF_BROADCAST flag.
> >
> > Signed-off-by: Thomseeen <thwa1@web.de>
>
> Is this your realname? For the kernel the s-o-b requires your realname. =
[...]

sorry, it is of course not. Messed up with my git configs. It should be:
Signed-off-by: Thomas Wagner <thwa1@web.de>
Should I repost the patch with a proper tag?

Regards
Thomas


Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF8818F38C
	for <lists+linux-can@lfdr.de>; Mon, 23 Mar 2020 12:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgCWLQX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 23 Mar 2020 07:16:23 -0400
Received: from mout.gmx.net ([212.227.15.19]:56449 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728011AbgCWLQX (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 23 Mar 2020 07:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1584962179;
        bh=Tc549tqZasCAKt97/gfAuJExiX7T9a6y21ylWVQyI2E=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Mjd4LkBYg9PZ3EdOhiuspK0rRXvt1rqip/VWsQUbcNPhXz8xZlNpUSk96S9SG2/S6
         Zu9TwD6uEXktmDo5EykSssJDsZ2ojKMz1LxVRzuUgwozGZrrLWZPdn4fJYbij4aV7h
         gzVF2AuxDDto9qcEdBsnGRZrCOPOSOdZLJt/063I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.103] ([84.176.144.33]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYeMj-1imS1Y0eBf-00ViY1; Mon, 23
 Mar 2020 12:16:19 +0100
Subject: Re: Need help in interpreting ip status output
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc:     Alex Blasche <alexander.blasche@qt.io>
References: <a6c8ef8c-5c72-7a2b-98df-0a30057c5fdc@gmx.de>
 <f029f731-25bc-a3f0-c5a9-380012a16839@gmx.de>
 <86b34b1b-7bda-e481-2087-1be8e64d2fed@hartkopp.net>
 <75a1a6b5-141e-e741-f6c2-bab5e9e4e541@gmx.de>
 <2cd75c78-cec7-09c0-ea80-fbedf37d37d5@pengutronix.de>
From:   =?UTF-8?Q?Andr=c3=a9_Hartmann?= <aha_1980@gmx.de>
Message-ID: <ece51328-6b3d-c8c3-0a38-cea39f71270c@gmx.de>
Date:   Mon, 23 Mar 2020 12:16:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <2cd75c78-cec7-09c0-ea80-fbedf37d37d5@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:v2iSFhjEiOzCOrzC6XYywA/Ti4EIRSYAXOR4mXMDCyehyBWyBWN
 TVH9c2+xvK8QTY9H9WWCws8gX7afAvkQRGpRcM+G0bnwD8BzfvJFwXAc7JTx55zx2G6dG5r
 O2P0FAP6uVpsG1I++ONqKp9xJjANpdNhlxf7OxvMwS32E8LP4BbjLVy1npC/8avvvtpf/iX
 l36TqttaZPPfEe/UGOyFw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:93KbyXMvhG8=:1yuUxSwGEBIZAEjWMqcUvb
 Ypz5R8I5QlNHkwAnjVcW2MB5ZyDEay4EZsBzNqBqR7QfdCUVqP5zX/pwLaIoYvI8kWgAjsh3v
 5twNjYjY1pk6+wT4CkMCRRBQPcuDoJL2g1rq1UTgnsc+V+4coJTiX4c8k6Gws+I0/4e2TjaIt
 wBBY3mm+9ZR1K6mbYfQloByLOVKVCOzj2X3Oh8lsUIOswUqR8jRbkIiiUuiVUUXI9bp5NQLis
 yRN430nEnCUipq6T8ljh8SjG9xVd/LTKEFwnPJxnxwk0hemI3IaQkQFSOVqyLptw966PJ97FU
 rgJAAH5JG4LsbH28M6vjXeZmsyq/Ii7aamQqCbCIONm1Lr8Woa0hny+EA8rciq30hJRAy+vHv
 Zk2oLGCDbSUFvPRAxm+D2rQ8MkBBufm44JUNnQSPgXPWK4hwuaiGYSgtIjF3BOQcTz+fK7BY9
 Iq0RQKPfyH+evD9mitFW0iegMEAfWJhs8dss7392Qy10oh8ne3WNQ1WmrgyFIBRK8MBQOj4WK
 uV/cABDXRYbva1kP7ZZqgOWJHJ+yGVUBlk98hc5TsGr1fsTZBN6tObhO63hBWYELjIqDUjzpV
 k9EdDgTQWRXfyYzPyRHldjI6iMzT1lF7ScuPvRHaGji5WmSMBccbyQ2o3Tp9zlOwxyOJgjm3l
 s+whE2N1rYjbv7wnlCxM+qtlE6SzECgzdMxovVCaZaTLaS3EMMNZbsYPEbjVE7HtJtD6QJ4VS
 FZN4Jxuv9ApCPwhmGpodctKVfaQnMszN5BigsgUYi4qSv8twWAB3mrfvcu/TW6QBp5fuVsEwp
 l4tM58K5dvDk3lNodDNp9PMoDkS/ZrIScS3AQjJt8z77+bac+rdFHK9/R2qLR5GG+pXEWtAd+
 BMBsA/vLm+E+6nkzXcRFY9GqoXuOKjje0zFl7ru7NWl9k/wWP5q+KgUBH11OEQrixXynKdYZv
 5Mhm8utXS52pMMJ59K1CiKltiLlf9qhXGlSfKynQo2ws+tWzRLFX78yXu73/T2j0+s0dhWXB/
 YrkGZplp72jld5YTtf7FjETYcWnRsnAz3lW4qtIqCsXTfBH0cfQQhXazNuO5fnUwlS5pUt3/t
 JrA3YaQ4w8w4I1ifaJioS6K0W71nVnahskuPpb8gaPRW53mlTnV7fUlJyOE6mWUXN+YnknZCV
 Ie0g+KeDjDfJQEnlXsvaBSx/CYGKuuonJiSd+fYbF6aXVx1ldTC1FSB6x5HKuy8jE1h1kX36D
 td0c2DwQ8i/FSJYso
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Thanks Marc! I'll forward this information.

Best regards,
Andr=C3=A9

On 23.03.20 08:44, Marc Kleine-Budde wrote:
> On 3/21/20 4:19 PM, Andr=C3=A9 Hartmann wrote:
>> Actually it's not my system. The report is from a customer doing a full
>> load test on an iMX8: https://bugreports.qt.io/browse/QTBUG-82610
>
> Which exact kernel are you using?
> Don't run any applications and/or kernel logs over the serial console.
>
>> I guess the customer should try a more recent Kernel than 4.14 first?
>
> Ack.
>
> Marc
>


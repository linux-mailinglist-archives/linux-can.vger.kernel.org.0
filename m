Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58DF33AC613
	for <lists+linux-can@lfdr.de>; Fri, 18 Jun 2021 10:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbhFRI3y (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 18 Jun 2021 04:29:54 -0400
Received: from mout.web.de ([212.227.17.11]:36861 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232389AbhFRI3y (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 18 Jun 2021 04:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1624004861;
        bh=V4E7DMwvoGe++o3d+07AXtDcXykJhut6IDTEHrKEH78=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=nqEHIOj/KdPH7vY83VGl1IhbbrVt4fJFp0dP2D0E2kBTpFSjtg5hTHMELqScEAKGL
         e0Pw2EzJ8ObDkQrqjMn0ShT61LX2Nl/LTyFn3uzr+NrcyybkBhFKNr5XlS2FM/7AGV
         5yYGYegzB6+Ms+EhNd5WnEtRVp0MmHvHIe8OGN/k=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from THOMASPC ([84.184.243.4]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MDPIf-1m4LVh44Dd-00GoTU; Fri, 18
 Jun 2021 10:27:41 +0200
From:   "Thomas Wagner" <thwa1@web.de>
To:     "'Marc Kleine-Budde'" <mkl@pengutronix.de>, <larssusaas@gmail.com>
Cc:     <linux-can@vger.kernel.org>
Subject: libsocketcan: Setting CAN FD data bitrate
Date:   Fri, 18 Jun 2021 10:27:40 +0200
Message-ID: <002c01d7641b$cd80bda0$688238e0$@web.de>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: de
Thread-Index: AddkGtGtBTcrThXOQNa4EdRCr0d4Eg==
X-Provags-ID: V03:K1:5h7CrSWGmkHjJkgK+xU/oizsLqi4ATqYTGnt6VTUC7qOsek0X86
 yRNzVTD2RW+NXKraz6ee9+5IPt/36eV5BttP+4345Dobbkk6rn3kRoPp2jJiUsMgz6g2MuE
 XgbVrhDpvCrgA9waW9qnZHpotbcUwUffFehuDDt9D9rpvchIsh55XqRldLh4JRxJENYzNHo
 oavwclD1tcXftX9dZwqvg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MYRRzENfMnc=:H3DTR5cOLSFAB0HVg0aC5L
 KBPeTMQASiwHUKBn9rqmlESAO/JOGeuRFQxQbeeDLH8wS9Uz7jQ7qpApCEIhBSWL65sWKnqcC
 AyU2lNrrinizRV72aKdTze9mmjN9dyz30bezdBDDvIxfgsysRNcVGhdbE8g/otOwjppYyRcUf
 Q9oIlOl8Op3RbhLnNcQiFSFY8M5g1wLf/9d+lf6n/upatyi5Qdl4KmUQLrMd/PRvzlYJkeaD1
 HY7ywPXIeupPINrC4SR4De93CBFNdv2cBz/BVNtMeKNO7UiroLUq36B7+aioCYHZtOGJRb5ku
 F9ko5k5PQy2HugGnlaCXdWbWYCWY9vU3uIS3KQ9PQfVbas54RH4SKxRPt6oatYHZ52ecTiQ+i
 0g2SbeisX39BSQzKaiWbZn389/McLsN8gLGQCR0/1zqvpaTo3rjZkvboHZWtl8R7z06tny9cO
 gg5Fuzkmlp30S8GjMGx+elsBl3n5efLd9HIThVP+HIn8Bv7i/VVi8jVG+s7j70zVu/9/4FtZt
 dlOyUY00swNZI2TvRwq0rg/L743vpklvX3/+AJwzZ7hr6dy0uLGveWBmQWJd2dU7Ki91kvNAh
 p2vHfTf0WPLFI/o9qDCHaOODcW3t6BM2KF8RbLdeY/c5h0odLrqAgg/bxSHrZ9gujlLgmDC1T
 DSsRkzX4/A3Lf90aXvYepr6WS/1keLQo/bhXu4eAdncZsUHDvM696wPJz/0oARCX7vRhrzbm5
 TOUvYTXL75w8xglm8O8uTJf9QBBkTrW0hipP+0U8nTIhZWqTrS+HlBu6E6U2dXGGw29l8TCa/
 t1RL9H9r5q/QjFO2slBASXziBW9rhU4gDHtyLTrUy9h+i6zulgBZqLClJx1/Tc+SMGF35juMW
 /DkANwaTElUH2RIHWVmxF6NNl2I78AXcSj24RkHCuf/MrKny8kplP9UnDEI5xAsx63Cp9/N6C
 5xWv3PFJLlgkXu4kj2isnW50mLirNYpzFATbu6oLSDRn1wIq6blpEWH+u4TTBU7EzFl/Dvz81
 xseshzlMn1IhH6qHzbsCOP+Qu9ExMja2EimiZ8PuuCbw4kkvykdPkZ8QoAfiLkBniprcwZzOm
 PXOlWP8fr9trFIx3y2HQlqYVSpApAx8gtdq
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Marc and Lars,

I have been searching for a possibility to set the CAN FD data bitrate
with libsocketcan recently and came across this [1] old thread.

It seems like there has never been a final patch?  If this is the case I
will look into it myself but I wanted to make sure there is no other
solution already present beforehand.

[1] - https://marc.info/?l=linux-can&m=153418949026459&w=2

Regards
Thomas Wagner




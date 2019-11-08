Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE4D3F50FA
	for <lists+linux-can@lfdr.de>; Fri,  8 Nov 2019 17:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfKHQWe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 8 Nov 2019 11:22:34 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.23]:27021 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfKHQWe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 8 Nov 2019 11:22:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573230149;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=EBKnJqcBu05XovwwN8SQLXu7rDqGqkxMDV3Nbj8Fze8=;
        b=c5VQ/eXPFc2lrIHqyyPuMo11YD9eI2VKHwimBZLH1c1tWHpDZRcH4LdtPEXfpDZvtd
        Gg2p9NQv5QxRVidHaojFqZItfsUpLW/FIO1njiusyEJX9YIvs4uI4QqscbD/r07VFFsM
        8UZJI5VZ0MecK0wlDuIYljUyQSaY6TtoB3w+mogdCngR7p6h+nBFtHAJChMNhKhYvk7t
        Ejg/Pqcr8TPC8z5A1VcI3S/NmYm5pxKhoZzvWMy0cdNIH2d8Wdo6rzrPXdo0Lw+/w/o4
        REWfHa4EzsAUw1xSE88V1pno+sHaDHw6U/Tfod8TP97N/5nJ7cDX/JgQiZBxKe4citRP
        zY3w==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMGX8h5mE1Q"
X-RZG-CLASS-ID: mo00
Received: from [192.168.1.177]
        by smtp.strato.de (RZmta 44.29.0 DYNA|AUTH)
        with ESMTPSA id C03a03vA8GMRV4D
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 8 Nov 2019 17:22:27 +0100 (CET)
Subject: Re: j1939: ELCE Lyon talk
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <20191108081331.cny5nlwq26ycgxug@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <b35500a0-b8cd-f9d5-f1c7-30a1c7926e07@hartkopp.net>
Date:   Fri, 8 Nov 2019 17:22:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191108081331.cny5nlwq26ycgxug@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Oleksij,

On 08/11/2019 09.13, Oleksij Rempel wrote:
> In case some one missed it, here is our talk on youtube:
> "Introduction to the J1939 Kernel Stack - Marc Kleine-Budde, Pengutronix"
> https://youtu.be/3NfN8B4-w8w

Very nice! Thanks for the URL :-)

Just for the records: The SocketCAN history started somewhere in 2001 at 
Volkswagen Group Research and we were able to contribute it to the OSS 
community in 2006. Jan Kiszka (today SIEMENS) created the project name 
"SocketCAN" on a German OSS site BerliOS "Berlin Open Source“ where the 
code for Linux 2.4.x and 2.6.x was uploaded for further development.

On 2008-01-28 the CAN netlayer bits and the virtual CAN driver was 
accepted by Dave Miller for upstream - which finally went into Linux 
2.6.25. Since Linux 3.3 we have a framework for CAN hardware drivers in 
place (with netlink configuration).

For those who want to know more about the CAN netlayer functionalities:

https://wiki.automotivelinux.org/_media/agl-distro/agl2017-socketcan-print.pdf

Best regards,
Oliver


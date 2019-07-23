Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 182B471914
	for <lists+linux-can@lfdr.de>; Tue, 23 Jul 2019 15:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfGWNVT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 Jul 2019 09:21:19 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:35766 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfGWNVT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 Jul 2019 09:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1563888075;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:References:To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=JQcSg0w+SP9BUls46URi/Ad5Nn/lzvAyku+3W/LfK6Q=;
        b=iO9NXJ5NRAwEAQEfJZwG4PvnLztQF6njaEEg96kG7D3zyvveMaVtqtCHzbLqYwS7oK
        E8J7DxPm52g8snt2luKbXphC35wGyORcp4ZUH2xgyaDO1I79AZ2DypUR9zKwbVnZitIV
        917XXO0Eq7HGHDWGnzkp2Ibj5nn2A/iBwSJ/ivkJth6+UFRrmJjERDGJsbGope6gtPPd
        Dv0/8H6bNz8VcirCJ9aS82s9oVoO5ZX3FoFUFOnSZW0QEwznoRDHJQHeF2imzx7E92h3
        hrgD3QsUG6xVLdywI3BdPDIGPRBQwECWTn6P6bB3AN70md+zkX10QyuIH1cQAj9yotyO
        QLjQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJV8h6liA="
X-RZG-CLASS-ID: mo00
Received: from [192.168.40.202]
        by smtp.strato.de (RZmta 44.24 DYNA|AUTH)
        with ESMTPSA id k05d3bv6NDLDeJM
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 23 Jul 2019 15:21:13 +0200 (CEST)
Subject: Re: [PATCH] can: Add SPDX license identifiers for CAN subsystem
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
References: <20190723124411.17353-1-socketcan@hartkopp.net>
 <df70ebc2-10ab-710f-6b64-f414cf02ca80@pengutronix.de>
 <c2efcd72-0e95-9024-cc82-d6974181eafd@hartkopp.net>
Message-ID: <6e32d78b-07a5-17bb-97fb-2865c435d438@hartkopp.net>
Date:   Tue, 23 Jul 2019 15:21:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c2efcd72-0e95-9024-cc82-d6974181eafd@hartkopp.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

FYI my checkpatch complained about the wrong format:

>> WARNING: Improper SPDX comment style for 'net/can/af_can.c', please 
>> use '//' instead

which has been fixed in v2.

But I haven't seen anything about DOS formatting in my patch here.
And git send-email should have worked correctly ;-)

Regards,
Oliver

>> ERROR: DOS line endings
>> #124: FILE: net/can/af_can.h:1:
>> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */^M$

Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E9C2CC7E5
	for <lists+linux-can@lfdr.de>; Wed,  2 Dec 2020 21:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgLBUff (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 2 Dec 2020 15:35:35 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.21]:15896 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgLBUff (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 2 Dec 2020 15:35:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1606941103;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=zVWqyUNXmY+BqsvQb4ckKO9IUPNmVxYeuAiBKwuZexQ=;
        b=HC06I1p1D18VrV+N1dHbDSVcZ5RF/RgoUpy4Opz+CFpdwK+4lD2FTHDFDb88HyPKQP
        TchGw+d7mMmpIDA3ARPcbqbSZ69yKBGbja98j8IvX2+Ii9oLCIgdwPXUiYS43o3yZVlG
        oZ1bjdbDGDgCS/tja3GJqFfAigEfIfl+iOCZCZ5MSWde/TSp8FTrDQaZrCruE3I/MLLF
        XMjhv8jjqJOE4St7bQmBXpg1sKXS1ba8236ADxR7tuUGsFxW1gTgowR1ZGwKR/Lv/s9S
        RFhAd+bScKp8Oq/vxYlvqpY9PxtRTjp4ukLWx/wvTceFdPQ1SZklPQZgs9xBdKHGMd/W
        hPbQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1rnbMYliT57T0lT8jNGw="
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
        by smtp.strato.de (RZmta 47.3.4 DYNA|AUTH)
        with ESMTPSA id n07f3bwB2KVfCyp
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 2 Dec 2020 21:31:41 +0100 (CET)
Subject: Re: Suggestion to have a functional addressing/broadcast option for
 ISO-TP sockets
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     Thomas Wagner <thomas.wagner@pa-systems.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc:     "thwa1@web.de" <thwa1@web.de>
References: <AM9PR06MB72834DE8FE187784AE914AB2B5F30@AM9PR06MB7283.eurprd06.prod.outlook.com>
 <bf1b3dd2-1a43-0bc7-d1db-f4ad010944ed@hartkopp.net>
 <AM9PR06MB7283F123B4B9B5A781597379B5F30@AM9PR06MB7283.eurprd06.prod.outlook.com>
 <a01a36d2-725f-6de0-51bb-5a40be8d3e5b@hartkopp.net>
Message-ID: <420f13ef-2993-7dd5-d537-085c1445be61@hartkopp.net>
Date:   Wed, 2 Dec 2020 21:31:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <a01a36d2-725f-6de0-51bb-5a40be8d3e5b@hartkopp.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Thomas,

On 02.12.20 16:42, Oliver Hartkopp wrote:
> On 02.12.20 15:58, Thomas Wagner wrote:
>> I would much prefer to work of the GitHub repo if possible, as I don't 
>> have a setup for newer kernels with CAN hardware.
> 
> Ok. Will send a notification here when the RFC code is ready to test.

I added a branch sf_broadcast to the repo:
https://github.com/hartkopp/can-isotp/commits/sf_broadcast

I will do some tests tomorrow, but you can already check it out for 
evaluation.

Best,
Oliver

Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73097161C31
	for <lists+linux-can@lfdr.de>; Mon, 17 Feb 2020 21:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbgBQUQv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 17 Feb 2020 15:16:51 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.20]:24317 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729334AbgBQUQv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 17 Feb 2020 15:16:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1581970610;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=nfU7kez+6dnYNaOkP1WVPxZgjuLk0SJuvfjt0gCy3YE=;
        b=IUWOxdhNjuRWVaAXhCsB0y1P0SopIYkcJ+omF23XmJA6wCb5gHNPGY36km9mMFUMdi
        7PsOqGxtHJAe3F7WlzxywPLp0pIq5p1SL7At3W0l5QXKIv7+uFSGxenZ7vyXKksRY5RC
        bcg628mejm8UwqChioMoJfCCuKRd4HaAmq0X+Yjq3lJEmKYYNGDNGk705HRBlBqH+ZE1
        Oe47aYeCoKYEICPVUyJxO9viWvKNnbYgnYggEnrCyLwIpaNNl70BaxMhehTN9vmUEIHm
        VB0LB7diFGYFaCac5Y5caFhELpHgX5I9XlzJLwi0wpx2G3TY3pdKosIoCT2skJoXrfEH
        mrEg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJX8h6k0Sg"
X-RZG-CLASS-ID: mo00
Received: from [192.168.1.177]
        by smtp.strato.de (RZmta 46.1.12 DYNA|AUTH)
        with ESMTPSA id g084e8w1HKGnqHw
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 17 Feb 2020 21:16:49 +0100 (CET)
Subject: Re: canfd through slcan via SocketCAN
To:     Chris Morgan <chmorgan@gmail.com>, linux-can@vger.kernel.org
References: <B1BB0B55-5478-4C06-AAC2-B27AB986755B@gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <ca7db9dc-991e-e2f7-a3a7-dc13a0880581@hartkopp.net>
Date:   Mon, 17 Feb 2020 21:16:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <B1BB0B55-5478-4C06-AAC2-B27AB986755B@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Chris,

On 16/02/2020 14.43, Chris Morgan wrote:

> I’m looking at options to add canfd support to embedded processors via serial using slcan. I’d like the devices to be available via socketcan. Looking at the slcan driver it looks like the MTU is something around 30 bytes and there isn’t any mention of canfd in the driver or in the userspace utilities. Am I missing something with this support? If slcan doesn’t support canfd yet is anyone working to add any?

The slcan driver implements the SLCAN aka Lawicel protocol, originally 
provided by http://www.can232.com/

See documentation at:
http://www.can232.com/docs/can232_v3.pdf

Other low cost serial CAN adapters adopted this simple protocol, see 
this overview:

https://github.com/linux-can/can-misc/blob/master/docs/SLCAN-API.pdf

By today there is no CAN FD capable CAN interface using the SLCAN 
protocol on the market!!

You would need to set a second bitrate (data bitrate) and you would need 
a separated data frame identifier for CAN FD frames.

Today:

t/T -> Classic CAN data frame
r/R -> Classic CAN rtr frame (not in CAN FD)

According to the above documents we would been able to use:

d/D -> CAN FD data frame (with BRS/ESI flags!)
k/K -> set FD data bitrates (analogue to s/S)

The biggest problem with defining these values/characters and adding 
them to the slcan driver in the Linux kernel, is that WE DO NOT KNOW 
whether future serial CAN FD interfaces will follow our suggestion.

Usually you have a hardware providing an API/protocol and THEN the 
driver developers write the driver - and not the other way around ;-)

Regards,
Oliver

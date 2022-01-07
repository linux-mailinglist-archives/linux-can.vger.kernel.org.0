Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F0D487783
	for <lists+linux-can@lfdr.de>; Fri,  7 Jan 2022 13:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238512AbiAGMPq (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 7 Jan 2022 07:15:46 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:41847 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238068AbiAGMPp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 7 Jan 2022 07:15:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1641557744;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:To:Subject:Cc:Date:From:
    Subject:Sender;
    bh=eOHW8rQFgl8DWOxjxsv3wjBUsbKFF7oOD0cXfD/MhNg=;
    b=rGnqIfw7y/u7RwV+nC80a1DEeFGbocjy6dgW0Eno4B2o+uJyw85epGAAUM6rt+F/3a
    xZMBe00ryuetF8xTbiksVq1ohO8mI1YfED7LmV7ZSfGVvJgS8ZYcmpeutile1hHYWTJS
    9GhKnf1GeK3nwGNWrDgdo/R+/2khSDbNkx0x+8hNqyKB7p8W6dxOMbXeH1CW4/WJKwgv
    NK/13NaY+pmTVvSp7hQ3HromwexfJbYMw4ZLLV3DrwfLe8SsfkEM4CvLagkPBe8ONBRg
    BcuySSiyeCPoxcpLL2jiYXcQiDZdUoIAqu01whQ6XHPWx3qFindBizN1b+uq4sfu9/gc
    6qHA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdd0DIgVuBOfXW6v7w=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a00:6020:1cfa:f900::b82]
    by smtp.strato.de (RZmta 47.37.6 AUTH)
    with ESMTPSA id Rb080by07CFh1pY
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 7 Jan 2022 13:15:43 +0100 (CET)
Subject: Re: Filter on controller level
To:     "Dr. Michael Lauer" <mickey@vanille.de>, linux-can@vger.kernel.org
References: <59415BCF-B758-410C-8007-3E6CA446ACA4@vanille.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <0761fe12-69bc-19db-951e-61e06d93d03e@hartkopp.net>
Date:   Fri, 7 Jan 2022 13:15:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <59415BCF-B758-410C-8007-3E6CA446ACA4@vanille.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Michael,

On 07.01.22 10:50, Dr. Michael Lauer wrote:
> Forgive me, if that’s a topic that already came up…
> 
> …reading the recent patch sets where hardware CAN capabilities are exposed to userland,
> I wonder why we still don’t have standardized ioctls (or whatever other means) to
> control the hardware arbitration masks that seem to be present in almost all CAN controllers.
> 
> In particular, I’ve stumbled over the https://github.com/craigpeacock/mcp251x, which is a driver
> that exposes the hardware filtering at module load time. Wouldn’t it be helpful to
> have a standardized way to control this? Also the isotp could make use of this.

In fact we started discussing about a common interface to configure CAN 
hardware filters in 2018:

https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/log/?h=can-hw-filter

But it didn't get further - probably because nobody really pushed this 
feature.

I have to take a look on that discussions around 2018-02-20 ...

https://lore.kernel.org/linux-can/98bcd448-4d2a-bf2f-ae5a-4db7f1eac896@pobox.com/

There were some patches flying around too:

https://marc.info/?l=linux-can&m=151949929522529

https://marc.info/?l=linux-can&m=151949942422563&w=2

But these patches are not available in https://lore.kernel.org/linux-can 
¯\_(ツ)_/¯

Best regards,
Oliver

Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C314934FE
	for <lists+linux-can@lfdr.de>; Wed, 19 Jan 2022 07:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351786AbiASGcK (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 19 Jan 2022 01:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350142AbiASGcJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 19 Jan 2022 01:32:09 -0500
X-Greylist: delayed 400 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 18 Jan 2022 22:32:08 PST
Received: from mail.kernel-space.org (unknown [IPv6:2a01:4f8:c2c:5a84::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DADFC061574;
        Tue, 18 Jan 2022 22:32:08 -0800 (PST)
Received: from ziongate (localhost [127.0.0.1])
        by ziongate (OpenSMTPD) with ESMTP id 439408cc;
        Wed, 19 Jan 2022 06:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=simple; d=kernel-space.org; h=date
        :from:to:cc:subject:in-reply-to:message-id:references
        :mime-version:content-type; s=default; bh=s2ZSs/PKN1DSOLrxonrNUr
        JXLFs=; b=FFl/L2e5n9Dss43S2mb3AijX09FGjDAVuagYKtR/DOITA9+qGJHCna
        B9imOZLJjJlqeJAdrt7HCQn/LWbFtEdHLgD4ZGow25Me9QyahO7my4Ez539/LzUJ
        /UcTebk6jroiCO/VWuXrl1Ch8Pf285Y3NRqGY7s/gKqsJfPqeHVrY=
DomainKey-Signature: a=rsa-sha1; c=simple; d=kernel-space.org; h=date
        :from:to:cc:subject:in-reply-to:message-id:references
        :mime-version:content-type; q=dns; s=default; b=sxzxGa9shXLeeLXp
        M+8UL81kODdWqJN2zDuBlnwk474hTW5UzyOmtHQUD2JLM7xNrz/9Q7800SKr0veS
        xk2R8h6TWLQUf4dCF/En2b9POBlkMqIOjSKyPhmMSSPyk/TNzDbUSjl6gp0pkeJe
        oHZUqI8FtTrDa2aC/XevhvWygmo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
        s=20190913; t=1642573525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FQiF7uSbYYHDzY09oc6psHu+j2M09N/5yPqOvHCHhJw=;
        b=TfrGJ9QkUyCnq4jKzWsVc5/X31/P7m4xsgODpHU4BihZKo81fQOQWT6IDuQCYF30EiqJt6
        mnAD8yGh0/mEAiJ2eeDPzK1phiCJtSC8vjLbQA31+c1XES0EpdKQ+mXe5aheck9bM626c/
        ITtMPv2hvYElHpkJM1qTKmGQCscOkQg=
Received: from dfj (host-79-40-232-124.business.telecomitalia.it [79.40.232.124])
        by ziongate (OpenSMTPD) with ESMTPSA id e7f79889 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 19 Jan 2022 06:25:25 +0000 (UTC)
Date:   Wed, 19 Jan 2022 07:25:21 +0100 (CET)
From:   Angelo Dureghello <angelo@kernel-space.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
cc:     gerg@linux-m68k.org, geert@linux-m68k.org,
        linux-m68k@vger.kernel.org, linux-can@vger.kernel.org,
        qiangqing.zhang@nxp.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>
Subject: Re: mcf5441x: flexcan FIFO and mailbox mode (was: Re: [PATCH v5 5/5]
 can: flexcan: add mcf5441x support)
In-Reply-To: <20220106111847.zjkrghehxr7mrkkt@pengutronix.de>
Message-ID: <1cf937d1-1e26-e611-c85f-f9e2128c225@kernel-space.org>
References: <20220106111847.zjkrghehxr7mrkkt@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

On Thu, 6 Jan 2022, Marc Kleine-Budde wrote:

> Hello Angelo,
>
> On 02.07.2021 11:48:41, Angelo Dureghello wrote:
>> Add flexcan support for NXP ColdFire mcf5441x family.
>>
>> This flexcan module is quite similar to imx6 flexcan module, but
>> with some exceptions:
>>
>> - 3 separate interrupt sources, MB, BOFF and ERR,
>> - implements 16 mb only,
>> - m68k architecture is not supporting devicetrees, so a
>>   platform data check/case has been added,
>> - ColdFire is m68k, so big-endian cpu, with a little-endian flexcan
>>   module.
>
> we're currently discussing the option that the user of a flexcan can
> switch between RX-FIFO and RX via mailboxes.
>
> I noticed that the mcf5441x currently is configured for FIFO mode. Have
> you tested the driver in mailbox mode?
>
> The reason that some cores use the FIFO mode is, that they cannot
> receive RTR CAN frames in mailbox mode. According to the IP core
> overview table, the mcf5441x can receive RTR frames.
>
> If the IP core supports reception of RTR frames, mailbox mode should be
> used, as it makes use of more buffers (16-2) instead of 6 in FIFO mode.
> Should we activate mailbox mode for the mcf5441x?
>

Ok, not sure why i selected FIFO mode initially, my application
actually is quite simple. Will try the switch to mailbox, sure,
looking into this.


> regards,
> Marc
>

Regards,
angelo

> -- 
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
>

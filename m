Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08348489456
	for <lists+linux-can@lfdr.de>; Mon, 10 Jan 2022 09:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242250AbiAJIyO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 10 Jan 2022 03:54:14 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.22]:44403 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242314AbiAJIwU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 10 Jan 2022 03:52:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1641804725;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=AFUaIzOxRV6KWtH/d8DwzpHMzOHDk6Xrb1vYKbtaK5M=;
    b=tgQ+nrmCgPV6QzH2sgTJmZxHLTnRd8MblS4qqN3AeKB4RzfpF/6eFU31zhg1criiJw
    V2MdAByzfIgiK1zdx/8vI56iJzMXjNB4mvxwIRpp2oazL9056BuKYazMlePsFxo1lHiB
    qSY2T3WXQx8riacPhl1KlPOQdEP95MtF89Roq2WPPyMpjTHZpPMXGtNtvZOYAoaXxtC8
    chN/cZ7N5eUIXT+DJIBCz5+tPr+uOyRK7vLxi6dpEs5x1ZWTE2Gll03T4Bu9H1ZU2pya
    8rrMUrkWJt2CSswCVDaE9bkKtnU4LjR1w/tlfxuRPKWwIal3ZSSki7lhG1b7CqLh5kEF
    KGqg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdd0DIgVuBOfXW6v7w=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a00:6020:1cfa:f900::b82]
    by smtp.strato.de (RZmta 47.37.6 AUTH)
    with ESMTPSA id Rb080by0A8q47Ia
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 10 Jan 2022 09:52:04 +0100 (CET)
Subject: Re: [PATCH] can: softing: softing_startstop(): fix set but not used
 variable warning
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc:     linux-can@vger.kernel.org
References: <20220109103126.1872833-1-mkl@pengutronix.de>
 <YdstmL4KSn70ziqx@x1.vandijck-laurijssen.be>
 <20220110082618.4jhkcwe3b7cm26ko@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <bd809029-9fc2-1e04-92f8-8efbb8b87d1e@hartkopp.net>
Date:   Mon, 10 Jan 2022 09:51:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220110082618.4jhkcwe3b7cm26ko@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 10.01.22 09:26, Marc Kleine-Budde wrote:
> On 09.01.2022 19:46:48, Kurt Van Dijck wrote:
>> Acked-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
>>
>>> out. Its stated that the functionality is not finally verified.
>>
>> The subsequent call works, but I wasn't able to produce the bus errors,
>> so I could not verify that is actually worked.
>>
>> And by now, I don't have access to the card, nor do I have a PCMCIA slot :-)
> 
> I think Oliver still has a laptop with a PCMCIA slot, but I don't know
> if he has that HW....

Huh. I can search for that card in the office when I get there next 
time. I have no idea if someone binned the card in the meantime - as the 
Laptops do not provide PCMCIA for years now ...

I'll take a look.

Best,
Oliver

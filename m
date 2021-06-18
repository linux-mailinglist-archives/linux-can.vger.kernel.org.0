Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342C53AD210
	for <lists+linux-can@lfdr.de>; Fri, 18 Jun 2021 20:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236260AbhFRSZ7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 18 Jun 2021 14:25:59 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:20296 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235400AbhFRSZ6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 18 Jun 2021 14:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1624040620;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=Z/7KQL3RWy5V/qdO8j/nQM+5/mCc4X05Celw40GdZhU=;
    b=D55goZDXDhLX/t8yp9hvVWgB1+eGojbvK9Tk8UFD0WFBr4pw0IR7EZQ3CZevbP6T9J
    9VYt8SVGNBkCRImGZ3WRopMPLkc7rCeM8++CEMnMLzKzdZxCC9PK1Zduw6TEM4e6d6ml
    dU6gRJoqfKu60YWbK58dMaPJsmsz97fI6GZJpkNcQlpBjlZ5htVyyUphWXyirJBUKLe4
    MV+JCAtuEkpN8edCL346ZoCz6PojDw0TMjf0UZWHaeqUbVW+qDJDyJGRU2KYp69SkHHd
    WFAuuFntp6mlzSupmPpL83eF2lr/5OAZQj+RIt8/zdZZFqGL0JEtYvHQ2wzpMDx+j03m
    AEGA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR9J8xozF0="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.177]
    by smtp.strato.de (RZmta 47.27.3 DYNA|AUTH)
    with ESMTPSA id N0b2dax5IINe2wt
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 18 Jun 2021 20:23:40 +0200 (CEST)
Subject: Re: MSG_CONFIRM RX messages with SocketCAN known as unreliable under
 heavy load?
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Harald Mommer <hmo@opensynergy.com>
Cc:     linux-can@vger.kernel.org
References: <c3fc258b-2f62-74ba-ca41-e6f839930020@opensynergy.com>
 <20210618091614.nqcvvmtf4wo4aejm@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <4dad20db-b9be-24c8-d97b-7cc614a7c7c9@hartkopp.net>
Date:   Fri, 18 Jun 2021 20:23:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210618091614.nqcvvmtf4wo4aejm@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 18.06.21 11:16, Marc Kleine-Budde wrote:

> 
> Even if the Linux Kernel doesn't drop any messages, not all CAN
> controllers support that feature. On the Linux side we try our best, but
> some USB attached devices don't report a TX complete event back, so the
> driver triggers the CAN echo skb after the USB transfer has been
> completed.
> 
> We don't have a feature flag to query if the Linux driver support proper
> CAN echo on TX complete notification.
> 

We have. It is set in struct netdevice.flags and called IFF_ECHO.

https://elixir.bootlin.com/linux/v5.12.11/source/net/can/af_can.c#L257

E.g. the slcan driver does not have this bit set.

Regards,
Oliver


>> But before declaring as "not reliably implementable with
>> Linux SocketCAN" I would like to be sure that it's really that way and
>> absolutely nothing can be done about it. Could even be that I missed an
>> additional setting I'm not aware of. But the observed behavior may as well
>> be something which is known to everyone except me.
>>
>> Of course it can be that there is still a bug in my software but checked
>> this carefully and I'm now convinced that under heavy load situations
>> MSG_CONFIRM messages are lost somewhere in the Linux SocketCAN protocol
>> stack. If there's no way to recover from this situaton I've to weaken the
>> next draft Virtio CAN draft specification regarding the TX ACK timing. As
>> this has some additional impact on the specification before doing so I would
>> like to be really sure that the TX ACK timing cannot be done reliably the
>> way it was originally planned.
> 
> Do you have some code available yet?
> 
> regards,
> Marc
> 

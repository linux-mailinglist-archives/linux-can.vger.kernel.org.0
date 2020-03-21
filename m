Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D73518E48A
	for <lists+linux-can@lfdr.de>; Sat, 21 Mar 2020 21:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgCUUvd (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 21 Mar 2020 16:51:33 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.23]:24093 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgCUUvd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 21 Mar 2020 16:51:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1584823891;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=demMsJlTuSYmvRYsjx6MOlj6N9RsRB0y9bAk3soRURk=;
        b=PYR4cLnrfAOiUv+nOhW06OEvCEfq0WBcvY3zwylNLNDpYKCNh2vPkcLSOUNMDtTp4/
        iSMNUr5YBV0QWoadm6xC9oZlfQ+zrL2kAx5ZaJn+ar1VUaF9cYhWMPiy589aUOlQgl35
        4Gl2LT6Dcn6SWukX7UJwfFy1JqM3a2qnu01yAcnTgMvbmfhC/PKDOgUecSCZGLYwJHGQ
        Rk/fPTV6T/zbLObx+fI0Co1D50cqyQzHTdsaEPpQhyJ8PgUHdr5+9rmpJGJrqsDOsH9F
        dhaV+kWmwGS2KpG0xd49U+u3Ve8x/hXnCwPTxPGpJJPpk09IWY6Z3k4DwSBKZ+grPI5e
        ZnGA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMGXsh6kk/L"
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
        by smtp.strato.de (RZmta 46.2.1 DYNA|AUTH)
        with ESMTPSA id R0105bw2LKpV73L
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Sat, 21 Mar 2020 21:51:31 +0100 (CET)
Subject: Re: How to send a CAN message while in a kernel module?
To:     Robert Barrows <robb.barrows@gmail.com>
Cc:     linux-can@vger.kernel.org
References: <CAOHJ0jSS=g4rQtXGkEFocafEqQAtxEOvq5eSXBC2FY_Esb23OA@mail.gmail.com>
 <2cb68f43-a551-c69d-b43f-3b044b948142@hartkopp.net>
 <CAOHJ0jRQx2U1APx92DTGFGzGLY9+tds3R4Sz8Tz8+LToWx_44g@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <ead77f42-f0f9-9b5a-ce5a-5e7f641d8a14@hartkopp.net>
Date:   Sat, 21 Mar 2020 21:51:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAOHJ0jRQx2U1APx92DTGFGzGLY9+tds3R4Sz8Tz8+LToWx_44g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 21/03/2020 20.15, Robert Barrows wrote:
>> You don't use sockets from INSIDE the kernel.
>> If you want to send CAN frames from inside the kernel you should use the
>> can_send() function from af_can.c
> Great to know! I Will look at that right away, any example(s) you could point
> me towards?
> 

You mainly need to look at raw_sendmsg() from linux/net/can/raw.c

Create a skb and set can_skb_reserve() and the other stuff and finally 
put your CAN frame content into the skb->data and invoke can_send().

You will at least need

#include <linux/netdevice.h>
#include <linux/skbuff.h>
#include <linux/can.h>
#include <linux/can/core.h>
#include <linux/can/skb.h>

Of course you don't have a sk reference as you don't have a socket in place.

So you maybe should check the content of alloc_can_skb() from 
linux/drivers/net/can/dev.c and use netdev_alloc_skb() or alloc_skb() 
instead of sock_alloc_send_skb() which needs sk to take care of socket 
specific memory quotas.

If you are unsure just post the code for a review.

Best,
Oliver


Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2954B6160CB
	for <lists+linux-can@lfdr.de>; Wed,  2 Nov 2022 11:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiKBK2m (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 2 Nov 2022 06:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiKBK2l (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 2 Nov 2022 06:28:41 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EE31EA
        for <linux-can@vger.kernel.org>; Wed,  2 Nov 2022 03:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1667384914;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=hOoU3pkO3rmhPzBFg7OMbk4A+jVbwc8a8pbkWVyHeOQ=;
    b=CHYsjdaFn0GBP+dg1ObbLMZHGMps8+M6vxxzE7xGDUMAJSWKLqb98w/BQIS23NxJtD
    JOLxQ2iskksXNzOyQ7nYH18VFbPVqznAnKD8zukARrEduZjDk1SeCCDLQHpUCMgFPjk6
    ruloWi3d5yOOfdaPhLGC4gwVFU1LdTkL++QQDM98QjuFQUTPnm+JZ0EDvd+vMCHpLF7J
    h4pssPwdVRWqloK86muJHzsrz8JhzVQH0iQCxsrk4CO0Q7tdfjmFDyigj8cZHjWt7DAH
    xsZuzx5oE/d8SsTDrzPPEDuZpvnLXRKKyTfaPbQxAVFWJcshZ2zK0dsdCttT+cX8cr8K
    vM/g==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr6hfz3Vg=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::923]
    by smtp.strato.de (RZmta 48.2.1 AUTH)
    with ESMTPSA id Dde783yA2ASXIyg
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 2 Nov 2022 11:28:33 +0100 (CET)
Message-ID: <ad18725f-e751-4e3f-3f99-ee6749a800c3@hartkopp.net>
Date:   Wed, 2 Nov 2022 11:28:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] can: dev: fix skb drop check
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org,
        Dariusz Stojaczyk <Dariusz.Stojaczyk@opensynergy.com>,
        Max Staudt <max@enpas.org>
References: <20221102095431.36831-1-socketcan@hartkopp.net>
 <CAMZ6RqJ+q5UmFrQFKKzxHzC4pOVT0HS6vD9509Rbth_cUFkjkg@mail.gmail.com>
Content-Language: en-US
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAMZ6RqJ+q5UmFrQFKKzxHzC4pOVT0HS6vD9509Rbth_cUFkjkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 02.11.22 11:17, Vincent MAILHOL wrote:
> On Wed. 2 Nov. 2022 at19:06, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>> In commit a6d190f8c767 ("can: skb: drop tx skb if in listen only mode") the
>> priv->ctrlmode element is read even on virtual CAN interfaces that do not
>> create the struct can_priv at startup. This out-of-bounds read may lead to
>> CAN frame drops for virtual CAN interfaces like vcan and vxcan.
>>
>> This patch mainly reverts the original commit and adds a new helper for CAN
>> interface drivers that provide the required information in struct can_priv.
>>
>> Fixes: a6d190f8c767 ("can: skb: drop tx skb if in listen only mode")
>> Reported-by: Dariusz Stojaczyk <Dariusz.Stojaczyk@opensynergy.com>
>> Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>> Cc: Max Staudt <max@enpas.org>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> Cross fire... I missed your patch and sent another one. That said:
> 
> Acked-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> 
> Thank you!

:-D

Yes! I would be fine with both of them. The main difference is the 
naming and the inline implementation.

So let us Marc decide ;-)

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Btw. my patch is missing the pch_can driver change which was already 
removed in net-next.

Best regards,
Oliver


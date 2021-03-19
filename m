Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46023418E4
	for <lists+linux-can@lfdr.de>; Fri, 19 Mar 2021 10:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhCSJzh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 19 Mar 2021 05:55:37 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.24]:15017 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhCSJzP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 19 Mar 2021 05:55:15 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1616147712; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ICuPCd/H6U7MxsjzqUiWPdWsXmpkPbNW2Na4UjgYqCFcrIQ+BfqX//8ZMJlZDKZm1Q
    jMpZWe7EupQEulmYElo32+MGuYIF9jy7J6X+T7bF5JV1e6VYAw++RFrc+Cn/AhEp9JgC
    b2dCUmfzG0+IQLzw9pmjD26/oCDQyFcF+WR2lAzTnHRVYZbID1r85g51rDAwwsCqwjCX
    bf01uInwVUi14K+YbrDL8QwZljxXzSKWm1V+V5cgLwAsu99yoGhcYxFVGFGsSbHZQzMx
    CLga2L6hNTqRZ2ba7yGZZGHydAYzx8fUfkM+6pFLOuX6lNZavd6G76BeaHVAzJaWb5/Q
    8s9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1616147712;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=NrsXwoxNZc6p598sG/uGu3ku4kAJb/CtVjZj4X29WAw=;
    b=l6URlexECHB72oYEukXAWB0+EuNutXZHDryRlr6o7xpBPbwgK/eP5/wXPiTRFQ0Z3l
    bRq7BJI0RPIdjw08NiCiAcDjfof+gUsYUACbobDMRGzpBmgimY1aniRwBNdhQpBfTo4G
    +M/mdC/PFq/FcTJFSVudAua+HVJD6N8nfTTYZLGW2/R88/NJWjK1SBCIBCGxwuWVPkeb
    yFgcFlXC6x+tg55tzLXP4MhMSCq2Fqw/uWFdkgVzZ4ufWtChoho7scrpZaWojXp2HxkM
    LeoGaGbMZrDPp7UK89SumFPxLRzqG7iRmCWndkRNrpqpXMtu0TDb4GLWowJKCwCdlzQy
    +DuA==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1616147712;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=NrsXwoxNZc6p598sG/uGu3ku4kAJb/CtVjZj4X29WAw=;
    b=TDbvQWxTifiuoNAV958LBGA5ifgL8eUxevWw6jfmam+KcZatte4SUaAnbuV4bw+xgU
    CKpZQapN6/P8/EEytCJRRa97/geA5vcOpS/JM5UzcCrJ7Z6oEWVL0OwQkLrqh0b4pPVJ
    0Rue7gUDEgwH8CnK5wRUvwuAZ64EmWZHz5kw6sxU2l/xXYJs+yW4T37+h0+CiQX1p97p
    EOEYZpdA0AUMPA936k91/wh9CJJwG9+IShrwEsO89KXDKhqxMUw1P7cFYYaChMI69v83
    SHrdpIGTegUhBvCQd1JwwvfxVnztja19DrjpyYZtUGIbNUCtW/m9/mu91YXalv9QR5yh
    64pg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTGV1iOMpjpw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
    by smtp.strato.de (RZmta 47.21.0 DYNA|AUTH)
    with ESMTPSA id R01debx2J9tB55g
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 19 Mar 2021 10:55:11 +0100 (CET)
Subject: Re: [PATCH] can: isotp: tx-path: zero initialize outgoing CAN frames
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
References: <20210318100233.1693-1-socketcan@hartkopp.net>
 <20210319082619.hssq4yhkjcxmtkqt@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <06ac59af-faaa-e9a6-0b65-0f70ab2648c2@hartkopp.net>
Date:   Fri, 19 Mar 2021 10:55:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210319082619.hssq4yhkjcxmtkqt@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


On 19.03.21 09:26, Marc Kleine-Budde wrote:
> On 18.03.2021 11:02:33, Oliver Hartkopp wrote:
>> Commit d4eb538e1f48 ("can: isotp: TX-path: ensure that CAN frame flags are
>> initialized") ensured the TX flags to be properly set for outgoing CAN frames.
>>
>> In fact the root cause of the issue results from a missing initialization of
>> outgoing CAN frames created by isotp. This is no problem on the CAN bus as the
>> CAN driver only picks the correctly defined content from the struct
>> can(fd)_frame. But when the outgoing frames are monitored (e.g. with candump)
>> we potentially leak some bytes in the unused content of struct can(fd)_frame.
>>
>> Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
>> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> What about skb_put_zero(), which I mentioned in my initial cover letter:

Yes, that would indeed be more elegant. Will send a v2 patch.

>>> Note here the "B" and "E" flags are set. Another possibility is to use
>>> skb_put_zero() instead of skb_put(), but with a bigger overhead. A 3.
>>> option is to only memset() the non-data part of the struct canfd_frame.
> 
> http://lore.kernel.org/r/20210218215434.1708249-1-mkl@pengutronix.de

I modified candump in a way that it always prints the entire frame 
independent from can(fd)_frame::len

diff --git a/candump.c b/candump.c
index 7bb854a..9683fc9 100644
--- a/candump.c
+++ b/candump.c
@@ -719,13 +719,13 @@ int main(int argc, char **argv)
                                 perror("read");
                                 return 1;
                         }

                         if ((size_t)nbytes == CAN_MTU)
-                               maxdlen = CAN_MAX_DLEN;
+                               frame.len = maxdlen = CAN_MAX_DLEN;
                         else if ((size_t)nbytes == CANFD_MTU)
-                               maxdlen = CANFD_MAX_DLEN;
+                               frame.len = maxdlen = CANFD_MAX_DLEN;
                         else {
                                 fprintf(stderr, "read: incomplete CAN 
frame\n");
                                 return 1;
                         }

And there you can see that in flow-control (FC) frames and consecutive 
frames (CF) especially at the end of the PDU you see uninitialized content.

So it does not help to only clear the non-data part of the struct 
canfd_frame.

Best,
Oliver

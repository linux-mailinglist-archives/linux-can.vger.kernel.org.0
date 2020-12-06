Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465662D02DA
	for <lists+linux-can@lfdr.de>; Sun,  6 Dec 2020 11:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbgLFKgl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 6 Dec 2020 05:36:41 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:31225 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbgLFKgl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 6 Dec 2020 05:36:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1607250766;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=+QOx2HW0WUQq7jBls7zlx5bUwmYV5PRavlY5FmaX93Q=;
        b=oxNYQvKTTZLDiuhu5lK4G50zTIGgyDGMBrcX/vJ2fI1vL7QJtacoQ+GCmQyWgrIW7J
        vhgInWRzCdxhua6fECJ3lEJZySNPzBkzZYUJ3mXl77Uv1HQmLkx9lwghYbIVy5q3NaXN
        +BeJbQ5gmc83YXcwYSaquk1vUcIAkiNHLq2PF6pkJlekC9rpnAz4QhGZGha/B9sEfVcN
        g+eRdEnafmJjrA6aBAe9kAuK8QY0zclawbJbCFhdUbKb89+jBH3il1r5WSKnn/zquavE
        LF5cBKo4xxJ0z8OhldoatTNwy/VevaNKD8iD0ErAOYU/hrZa6u2Bn7g6gociwhMA18yt
        Mzsg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3HMbEWLWkJK3wAH"
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
        by smtp.strato.de (RZmta 47.3.4 DYNA|AUTH)
        with ESMTPSA id n07f3bwB6AWiMlm
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Sun, 6 Dec 2020 11:32:44 +0100 (CET)
Subject: Re: [PATCH] isotp: do not validate RX address when the broadcast flag
 is active
To:     Marc Kleine-Budde <mkl@pengutronix.de>, Thomseeen <thwa1@web.de>,
        linux-can@vger.kernel.org
References: <20201204135557.55599-1-thwa1@web.de>
 <d7f4c720-199f-8837-829e-653c435f52d1@hartkopp.net>
 <1e1ab72a-18e3-e237-331a-6c15ffd651ad@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <91c1255a-9f2b-d136-7830-d5041d7dafc3@hartkopp.net>
Date:   Sun, 6 Dec 2020 11:32:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1e1ab72a-18e3-e237-331a-6c15ffd651ad@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 05.12.20 22:23, Marc Kleine-Budde wrote:
> On 12/5/20 10:15 PM, Oliver Hartkopp wrote:
>> On 04.12.20 14:55, Thomseeen wrote:
>>> EADDRNOTAVAIL shouldn't be thrown when an invalid RX address (e.g. NO_CAN_ID)
>>> is set while the socket is used with the CAN_ISOTP_SF_BROADCAST flag.
>>>
>>> Signed-off-by: Thomseeen <thwa1@web.de>
>>
>> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> Should this be squashed into "support for functional addressing"?
> 
> Can you re-post the two or three isotp patches, as they should go into
> can-next/net-next?
> 

Yes, will do.

>> 98bef9295d07 can: isotp: isotp_setsockopt(): block setsockopt on bound sockets
>> 21f10f1b5c3a can: isotp: add SF_BROADCAST support for functional addressing
> 
> Marc
> 

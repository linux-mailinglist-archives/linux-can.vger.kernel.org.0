Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6696E2A1F47
	for <lists+linux-can@lfdr.de>; Sun,  1 Nov 2020 16:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgKAPsX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 1 Nov 2020 10:48:23 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.169]:24347 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbgKAPsV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 1 Nov 2020 10:48:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1604245699;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=yAojNvsTMXwci+PgwEgeEyrFqh/svZFGBqzhQ51cJbk=;
        b=PPRZ067dYFeyXG03II9SgDM/g47z54k9IBT4HSnVoZVGAEVu3+KEFzJkfY0QCPLvDL
        IVTz426xbjVSqmnDcYIDrwQZFctLdpH0+6oXX7PguQk7IhLYxl4uKB7NVuZMj+tRb8YY
        uU9kvygoXCEt5V0/HNC3c/uKx7Mi4w94/TJnlG58/mj0mdJRvFOaCeMZrSsldqmOG8Yx
        Rbh6/hM4CnK2mv0Ip6faXZy8TV1vFaNyzXj9sTo9W9wsEI5BW7dH+mukjG+L0Panleym
        A/hIibqKY5H48+3hcUf6LUB6odyQHSLHx9W0cmEZGBrcti5Tm5uKU8crbCtEq+Gqdnpf
        Skgw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR9J8xtpw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.3.0 DYNA|AUTH)
        with ESMTPSA id L010bewA1FmJ8Op
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Sun, 1 Nov 2020 16:48:19 +0100 (CET)
Subject: Re: [PATCH] cangen: flush the CAN frame at each iteration
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
References: <20201101145712.489795-1-mailhol.vincent@wanadoo.fr>
 <5ecff3df-2e94-8702-3894-3fcd70364552@hartkopp.net>
Message-ID: <2ef6fb30-9fa8-99ee-39f7-e39bfb06f06c@hartkopp.net>
Date:   Sun, 1 Nov 2020 16:48:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <5ecff3df-2e94-8702-3894-3fcd70364552@hartkopp.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


>> diff --git a/cangen.c b/cangen.c
>> index ab8122c..d7392b6 100644
>> --- a/cangen.c
>> +++ b/cangen.c
>> @@ -384,7 +384,7 @@ int main(int argc, char **argv)
>>       }
>>       while (running) {
>> -        frame.flags = 0;
>> +        memset(&frame, 0, sizeof(frame));
> 
> But this patch breaks everything which is not in random mode.
> 
> Analogue to frame.flags we just need to clear frame.len8_dlc

I've tagged you as author because of the great description but changed 
the code a bit ;-)

https://github.com/hartkopp/can-utils/commit/0b6af299d1b92c76447ce24f31702efb8eda02fa

Best,
Oliver


Return-Path: <linux-can+bounces-1958-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E479C419D
	for <lists+linux-can@lfdr.de>; Mon, 11 Nov 2024 16:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3222D283AAD
	for <lists+linux-can@lfdr.de>; Mon, 11 Nov 2024 15:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248EB1A08D7;
	Mon, 11 Nov 2024 15:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="QU8UlbYH";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="46wmKiX6"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E4E1A08C2
	for <linux-can@vger.kernel.org>; Mon, 11 Nov 2024 15:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731337861; cv=pass; b=MaICUtaqw1JShbXK0XBvYNb0Mi/pDbH0m/aPkd1Vhbj4lv3xrkZ2cKOLvWv8mLB+59LCL9bR+DrAAhTfT6qpVtSvGfwoxS5Mb6aU6G4QD6whPAJWz2YUvMqt71lH8yPI7EgYwYYYannWe5N88ODwCeD3ct+dzJVmfAf2kizf5kA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731337861; c=relaxed/simple;
	bh=WS7nkuU7tlw/dN/Oa94RgfoDrmgF54NfeHSUnADPV04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gmdi7w0NzP39QSF2nTK8qRq8AsPTxoN2G5oKfPTv70zBRr0wsbh3PWanIIOeTbAflFzt6kQLl+3qWgqSCe3d8GBlLj0VjaZQdmJI8AoJkSa046EiUC9Ef2ytTJHfahQ9i3TYt+96Q/UXbBpWUHBHdw5JZR3HEDm0YcNW4SaJh6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=QU8UlbYH; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=46wmKiX6; arc=pass smtp.client-ip=81.169.146.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1731337854; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=YXHmJWGw2A6UlP3zShb1PI8OfMv4JBz4CHRjybgYNGzny96D8l2blSMqyesYbPIDbD
    e8/skP04uJSvlBqwqczk0fJ/EsUKGAEuzJBQjKawme2zcngIThh2AVCl9+By+Rt8coS8
    mpxAH3bhSv6XaU24pYtF4oPIePYYV26m3GiCUCD7yo+z696ITEpWbK92CzU4P7mquIro
    A3w5bBlDHNl2Gw5s+ABjQVp6Lqt3wu2hyeKPc6PprNsoydJmyDkh/NgCVz56Hbg94sfF
    4DWQwcIF5Ib0pO0rRZcJvD+gxRzyUSFvudX/ttKNQyKfMe2DQojaJPgcoLyMweX2Vt04
    EgXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1731337854;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=R2R3EmTk2dRAqNcXRnnv1AqugrseYKZ0PNjkliYqZXw=;
    b=J7WF7VhOVMvgtVAuRIYQphPj6MzSvYnYOWvI/fH4RFtQLu+bg3cmN6Fsf+jAIStXuD
    hdp0M/WcmQOelQ86mp7jWXSww6kPMJxkI4QufKZAw2NL2IMnqu9n1Uu4ClmAPH1Zt9Sa
    d/AhRtj2qnV5UWvl2NNMUqpCGtD9LsgGhGcogaPlXZ0hVq4P1w8V7gpIdbEIVKda6O70
    KY9/vwP4Zpgo2Tvuk/+ewS+z+jUEU2rK4X23VyVXchwfTeQPMW/cBuK4zfLmwB2TWpIM
    /JkkCyPNhwnNqJusEQxo/LwRWSN6pcTcm6x5HdKKctIUlAqaa+2K9vNxlg5bfdUDqTtD
    hmiw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1731337854;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=R2R3EmTk2dRAqNcXRnnv1AqugrseYKZ0PNjkliYqZXw=;
    b=QU8UlbYHK1VXffyGlPhrwGsoL7m92ukvDp7yrHJx31cmW0Ocxvsb5Jv2BQmMlHpJxM
    zwU0xuF4uXbu983ORTU0onckwMWVziBwjs5UaXfZ5WWpbwxCuGENIEsbPKj4Tc+g782k
    K8TqaSy8aHVsIUkfcNd5812c31K5YclViaPx30Zfv3vgMwpct9wQlDF9svTAa/yryyXV
    7jKmt5NeVd+gcb8Q57iI8z+BXb2seM4DbAJMpCXwXBGfghQSezVYUf699wIG6Oa3/hMk
    CqUQ0M+vKbr+XA4HqHtE5pebZ1sysy4xKTvlWJHRodwW33dMPC6Xng8xpmClHsCIKK7W
    mzkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1731337854;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=R2R3EmTk2dRAqNcXRnnv1AqugrseYKZ0PNjkliYqZXw=;
    b=46wmKiX605umMtLLrZ0uvls42LMkTRwQdIqXCr4v3kyFz7ExA0Q1Lh0A6XICxu34cd
    7LpR8Dp7vQKdefVJR3AA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+5xtv9aJ67XA=="
Received: from [IPV6:2a00:6020:4a8e:5000::9f3]
    by smtp.strato.de (RZmta 51.2.11 AUTH)
    with ESMTPSA id K63ada0ABFAr8Ij
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 11 Nov 2024 16:10:53 +0100 (CET)
Message-ID: <782bb114-353c-4094-8611-902b5d88c1d9@hartkopp.net>
Date: Mon, 11 Nov 2024 16:10:53 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 8/8] iplink_can: add CAN XL
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, linux-can@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Robert Nawrath <mbro1689@gmail.com>
References: <20241110160406.73584-10-mailhol.vincent@wanadoo.fr>
 <20241110160406.73584-18-mailhol.vincent@wanadoo.fr>
 <ff161f8d-6302-47b1-984d-8964eb75fc9f@hartkopp.net>
 <8ea3c2b2-7b8b-4532-9c72-7ed12813038c@wanadoo.fr>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <8ea3c2b2-7b8b-4532-9c72-7ed12813038c@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11.11.24 16:03, Vincent Mailhol wrote:
> On 11/11/2024 at 23:13, Oliver Hartkopp wrote:
>> On 10.11.24 17:01, Vincent Mailhol wrote:
>>> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>>> ---
>>>   ip/iplink_can.c | 209 +++++++++++++++++++++++++++++++++++++++++++++---
>>>   1 file changed, 196 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/ip/iplink_can.c b/ip/iplink_can.c
>>> index 54acc65c..43018c54 100644
>>> --- a/ip/iplink_can.c
>>> +++ b/ip/iplink_can.c
>>> @@ -26,6 +26,10 @@ static void print_usage(FILE *f)
>>>           "\t[ dtq TQ dprop-seg PROP_SEG dphase-seg1 PHASE-SEG1\n \t 
>>> dphase-seg2 PHASE-SEG2 [ dsjw SJW ] ]\n"
>>>           "\t[ tdcv TDCV tdco TDCO tdcf TDCF ]\n"
>>>           "\n"
>>> +        "\t[ xl-dbitrate BITRATE [ xl-dsample-point SAMPLE-POINT] ] 
>>> |\n"
>>> +        "\t[ xl-dtq TQ xl-dprop-seg PROP_SEG xl-dphase-seg1 PHASE- 
>>> SEG1\n \t  xl-dphase-seg2 PHASE-SEG2 [ xl-dsjw SJW ] ]\n"
>>> +        "\t[ xl-tdcv TDCV xl-tdco TDCO xl-tdcf TDCF ]\n"
>>
>> s/xl-d/x/ ?
>>
>> xsample-point seems more handy than xl-dsample-point
> 
> Makes sense. Then, what about:
> 
>    sed -i "s/xl-d/x/g;s/xl-/x/g" ip/iplink_can.c
> 
> This will give:
> 
>    - xbitrate, xtq, xprop-seg, xphase-seg2, xsjw
>    - xtdc-mode, xtdcv, xtdco, xtdcf
> 
> Note that the above sed command is fully functional. I already staged it 
> in my local repo, works fine. I will not send a new series just for this 
> one. Instead, you can just try the sed command and tell me what you think!

Yes, that's nice!

I can see that even without running sed ;-)

Many thanks!
Oliver



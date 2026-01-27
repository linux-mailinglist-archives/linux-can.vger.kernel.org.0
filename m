Return-Path: <linux-can+bounces-6311-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANQiLMi9eGn6sgEAu9opvQ
	(envelope-from <linux-can+bounces-6311-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 27 Jan 2026 14:29:44 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A4394E78
	for <lists+linux-can@lfdr.de>; Tue, 27 Jan 2026 14:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2494A3045205
	for <lists+linux-can@lfdr.de>; Tue, 27 Jan 2026 13:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F48735771E;
	Tue, 27 Jan 2026 13:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="G14SLhEQ"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E676235771B;
	Tue, 27 Jan 2026 13:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769520464; cv=none; b=QPo1+km5/YtKA0o2vIy00t7nkkubUDSrakO1nSQvSpZ9mzW4OURKiSw7dqgx0CYpUKAxKdtDa4XfInpa5d6p8oXUAd53TRdl+K6yeBBl2WqxQavm5dDO6JYt0lu3RysXos12kGwOvt1ovGHC5T4KeLQe4q08o4h27ZchoR2NznM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769520464; c=relaxed/simple;
	bh=GtsJDvUWwbErczLsuwwXWjSyH/0nFpRBaMz8vmqOSQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=e1wpLWj0yswJ7EX2tMKBTL9DRLLp49RvnFx2cfpS2vwt9XjUtNRaNC+at+XdP2so5kciNB1MejaJgU6noYRj5EtXi03ypNHApf6lDXsCxWcA1KUzNOKAia2DSyqsbJWOL4Vrkrr/n6R5BLEPZKVFMxi1QLY7rwwQTcONlLFVY/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=G14SLhEQ reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4f0mRb5bPTz1DPkB;
	Tue, 27 Jan 2026 14:27:39 +0100 (CET)
Received: from [192.168.0.5] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4f0mRZ6ycpz1DHcc;
	Tue, 27 Jan 2026 14:27:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1769520459;
	bh=VEZ7R8rV/rbt4KsQlqCcr+sFAvlf8npmNIH7iTkQ7oQ=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To;
	b=G14SLhEQyU7ddjPIExfKo3LZqd3moQhAY9Hi+Fekza/FOOW6bPZ9zT/wy0XQVBdrL
	 MulZwDUCzfO8zhd2HnsxTSxKOBaimRjx9hw9bh46sLb3kN3J2qQCeY/G970K5hN4AK
	 2E8f6syKe4TbHmATdQzQhjhvGI5BRBT+dWGNDHLyQFixCjx+Ieq5NLm9J22TXHAl/7
	 gJcISoMObUNhtcXnU+gNx+ZWd+RGiuW0AO3+9xk5x34kTWjtUOICcziGzD+gr2/8/l
	 Iz0BHItitGAyMRPAWEDcqpvxK7PbTR9s4OgIRg/UwKW8BqhBBNXU/9y02IcTpYU2Br
	 H4qmkzfc86sjQ==
Message-ID: <c63eb30b-5856-4fc5-84e1-78e07125f0e7@gaisler.com>
Date: Tue, 27 Jan 2026 14:27:38 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/15] can: grcan: Add clock handling
To: Marc Kleine-Budde <mkl@pengutronix.de>
References: <20260122121038.7910-1-arun.muthusamy@gaisler.com>
 <20260122121038.7910-5-arun.muthusamy@gaisler.com>
 <20260123-astonishing-swine-from-mars-0f9b52-mkl@pengutronix.de>
Content-Language: en-US
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 mailhol@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
 Daniel Hellstrom <daniel@gaisler.com>
From: Arun Muthusamy <arun.muthusamy@gaisler.com>
In-Reply-To: <20260123-astonishing-swine-from-mars-0f9b52-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[gaisler.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	R_DKIM_PERMFAIL(0.00)[gaisler.com:s=simplycom2];
	TAGGED_FROM(0.00)[bounces-6311-lists,linux-can=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gaisler.com:~];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arun.muthusamy@gaisler.com,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gaisler.com:mid,gaisler.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 38A4394E78
X-Rspamd-Action: no action


On 1/23/26 14:44, Marc Kleine-Budde wrote:
> On 22.01.2026 13:10:27, Arun Muthusamy wrote:
>> From: Daniel Hellstrom <daniel@gaisler.com>
>>
>> Add clock handling and add error messages for missing 'freq' DT property.
>>
>> Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
>> Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
>> ---
>>   drivers/net/can/grcan.c | 19 ++++++++++++++++---
>>   1 file changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
>> index 3b1b09943436..538a9b4f82ab 100644
>> --- a/drivers/net/can/grcan.c
>> +++ b/drivers/net/can/grcan.c
>> @@ -34,7 +34,7 @@
>>   #include <linux/spinlock.h>
>>   #include <linux/of.h>
>>   #include <linux/of_irq.h>
>> -
>> +#include <linux/clk.h>
>>   #include <linux/dma-mapping.h>
>>
>>   #define DRV_NAME	"grcan"
>> @@ -1644,6 +1644,7 @@ static int grcan_probe(struct platform_device *ofdev)
>>   {
>>   	struct device_node *np = ofdev->dev.of_node;
>>   	struct device_node *sysid_parent;
>> +	struct clk *clk;
>>   	u32 sysid, ambafreq;
>>   	int irq, err;
>>   	void __iomem *base;
>> @@ -1663,8 +1664,20 @@ static int grcan_probe(struct platform_device *ofdev)
>>
>>   	err = of_property_read_u32(np, "freq", &ambafreq);
>>   	if (err) {
>> -		dev_err(&ofdev->dev, "unable to fetch \"freq\" property\n");
>> -		goto exit_error;
>> +		clk = devm_clk_get(&ofdev->dev, NULL);
>> +		if (IS_ERR(clk)) {
>> +			dev_err_probe(&ofdev->dev, PTR_ERR(clk),
>> +				      "Failed both to get \"freq\" property and clock for fallback\n");
>> +			err = PTR_ERR(clk);
>> +			goto exit_error;
>> +		}
> I think devm_clk_get() either returns an error pointer or a valid clock
> pointer.
>
>> +		if (clk) {
>> +			ambafreq = clk_get_rate(clk);
>> +			if (!ambafreq) {
>> +				dev_err(&ofdev->dev, "Invalid or Uninitialized clock\n");
>> +				return -EINVAL;
>> +			}
>> +		}
>>   	}
>>
>>   	base = devm_platform_ioremap_resource(ofdev, 0);
>>
you are correct, since devm_clk_get() returns either a valid clock pointer or an error pointer, "if (clk)" check is indeed redundant.



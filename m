Return-Path: <linux-can+bounces-7894-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z+2uEFIgPGr2kAgAu9opvQ
	(envelope-from <linux-can+bounces-7894-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 24 Jun 2026 20:22:10 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E0C6C0B69
	for <lists+linux-can@lfdr.de>; Wed, 24 Jun 2026 20:22:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="ehI/ywKU";
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7894-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-7894-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48268302F0F5
	for <lists+linux-can@lfdr.de>; Wed, 24 Jun 2026 18:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694043242B2;
	Wed, 24 Jun 2026 18:22:07 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FACC3242D4;
	Wed, 24 Jun 2026 18:22:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782325327; cv=none; b=Or582a2mHJRHcNfdgQ/IdIf/NzVsICrzLy6XY8LXKKqz0QaXFoSAWqvCG+Q6P8oEGZ+9yX+wwufX0icpj/trHjZtXfG+qHBZd20ag3SPJ0lV4Fj+PQ/JzHpFALRcacINS7gpLDt2ynlIXpyPVpBHmjxIA/RCaeo/4em5N/DVR3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782325327; c=relaxed/simple;
	bh=wdayrJRpYrkZ5HsYZt0DXqpN3IS5kur6okD4IL2e6KA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MSnfMLUY+yQAS65HLmS6fuOXS6gt3+f4l9paljAA6g0RMA7W0LcXq+BpEVowgH9aIymQT244JIya05+QcQ8DjubMVLgVbU9wO/6hMOPEFFfG9L/3dyAKw/HNlgDq/t1q3kW+ETqzzee1dveOl569CURGGrucqV4VTYaox3Gk7HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehI/ywKU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127291F000E9;
	Wed, 24 Jun 2026 18:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782325325;
	bh=hk8mTO54jlUiL8rS7zZDZMwBNKeg0NA390k5uA1+OoY=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=ehI/ywKUxmFBwdT9Q+0f1flxhz46TiXmw+v0vZdF3/DgXnbhrqIH/YRWtgDLOnsEK
	 6oK2oT5atf0FDFm2LKfIUJzReqt17xfdT56nEPKio3zYCs61PlGPB1y/H/vChM8BJg
	 xvr5E472H3hbkH/2h9VWcZOuMIk2LjT8AgNvJUUhoezmJEmSKUPqUK8Jnsc6RFVROC
	 zaLeIUkk2CiLAa3zsbNbL3/i9AwTJIDvVvPyH0mhyckYI6uSeFv3YeOYGiJDp4kaq+
	 EsQgzFf3iPI6LI1ytOF1W3jRqUmWQHsWEThYjfvLck0w8mOI4VHP5OZaFFd7uJz4iI
	 55FIuSO/0O9xQ==
Message-ID: <12d20349-6e76-47a6-ab7d-e7429b50de35@kernel.org>
Date: Wed, 24 Jun 2026 20:22:03 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: c_can: Use platform id data when OF data is absent
From: Vincent Mailhol <mailhol@kernel.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260624054927.22851-1-pengpeng@iscas.ac.cn>
 <76288461-98f7-4c72-9d97-3589d301cd9e@kernel.org>
Content-Language: en-US
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <76288461-98f7-4c72-9d97-3589d301cd9e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7894-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pengpeng@iscas.ac.cn,m:mkl@pengutronix.de,m:linux-can@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mailhol@kernel.org,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mailhol@kernel.org,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 89E0C6C0B69

On 24/06/2026 at 11:53, Vincent Mailhol wrote:
> On 24/06/2026 at 07:49, Pengpeng Hou wrote:
>> The platform driver keeps controller metadata in both the OF match table
>> and the platform id table.  Probe reads the metadata with
>> device_get_match_data(), which does not fall back to platform id-table
>> driver_data.
>>
>> When the device is matched through the platform id table, drvdata can
>> therefore be NULL before it is dereferenced for msg_obj_num and the
>> controller type.  Fall back to platform_get_device_id() when firmware
>> match data is not available.
> 
> So, you are telling me that this patch fixes a NULL pointer
> dereference? In that case, it needs to be backported. Please add a
> Fixes: tag.

Also, were you able to trigger that NULL pointer dereference?

> Fixes: 5e6c3454b405 ("net: can: Use device_get_match_data()")
> 
>> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
>> ---
>>  drivers/net/can/c_can/c_can_platform.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
>> index 19c86b94a40e..564c9e5b4c2c 100644
>> --- a/drivers/net/can/c_can/c_can_platform.c
>> +++ b/drivers/net/can/c_can/c_can_platform.c
>> @@ -263,9 +263,17 @@ static int c_can_plat_probe(struct platform_device *pdev)
>>  	int irq;
>>  	struct clk *clk;
>>  	const struct c_can_driver_data *drvdata;
>> +	const struct platform_device_id *id;
>>  	struct device_node *np = pdev->dev.of_node;
>>  
>>  	drvdata = device_get_match_data(&pdev->dev);
>> +	if (!drvdata) {
>> +		id = platform_get_device_id(pdev);
>> +		if (!id)
>> +			return -ENODEV;
>> +
>> +		drvdata = (const struct c_can_driver_data *)id->driver_data;
>> +	}
> 
> Reduce the visibility of id:
> 
> 	if (!drvdata) {
> 		const struct platform_device_id *id;
> 
> 		id = platform_get_device_id(pdev);
> 		if (!id)
> 			return -ENODEV;
> 
> 		drvdata = (const struct c_can_driver_data *)id->driver_data;
> 	}
> 
>>  
>>  	/* get the appropriate clk */
>>  	clk = devm_clk_get(&pdev->dev, NULL);
> 
> With the Fixes: tag added and above nitpick addressed:
> 
> Reviewed-by: Vincent Mailhol <mailhol@kernel.org>


Yours sincerely,
Vincent Mailhol



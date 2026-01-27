Return-Path: <linux-can+bounces-6312-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MheJpjGeGmltAEAu9opvQ
	(envelope-from <linux-can+bounces-6312-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 27 Jan 2026 15:07:20 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0717095553
	for <lists+linux-can@lfdr.de>; Tue, 27 Jan 2026 15:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E846D300C928
	for <lists+linux-can@lfdr.de>; Tue, 27 Jan 2026 14:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B000F341AD7;
	Tue, 27 Jan 2026 14:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="JB2SegbV"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F8E28F50F;
	Tue, 27 Jan 2026 14:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769522822; cv=none; b=J+dw+I6rlLjcc2i5hgLfVQA82pVbnjMiC13VKNKTz6w6ZODYemvHycRZ74hbSgqDPctIelnN1JwxyI3cauJSGAgzC+NNTyJBUkuHhMgp0DmWY3JCTqJnbisPfjReS348XpmAnDehdHufeQIxzAEtzDD3dx29L1mQzA/opb6eVdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769522822; c=relaxed/simple;
	bh=iq0UttMh7N/IF+gAyEtXtfhE/MtFIE2jRuqztHf0kAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=G4Vf0jFXobkPYajSoF/J03L6sjGFZUyPK8q9gdSq+0vawQ9QCWUPhqW43DC2ldaRB6ZGDUh9uI0BMS4D1ppGlIC71zYjCVfhtw5MdblIY+J951U8vqDN87N8pMwzG9+2Gsq0xU42GlIFItk45OlLUf+mAWf08l7SHGmMQKeH52o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=JB2SegbV reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4f0nJv4qKDz1DR2Z;
	Tue, 27 Jan 2026 15:06:55 +0100 (CET)
Received: from [192.168.0.5] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4f0nJv2Fyhz1DQrn;
	Tue, 27 Jan 2026 15:06:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1769522815;
	bh=sMLdOWKpMTSBB1sqHLGysA33Sje6elBGI1+aRuBJoEI=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To;
	b=JB2SegbVhu8iRYFrO9b5XnLyAwtegTXtrUB5yxOt0goEEJOva9peWLho5ifKsCIMY
	 TfSJQYSYr8oIACb6Vt98Lh8jMJyWaJE3g5U6t/o5nADAsI6ZY4zgjlPY+MrnRu0hLS
	 p+1PSC3t4kwJ4y0572yZ2QMsy5xu21bS9X3p9ThqOfyc3I3+DoNimTNM9Hgi4Ld9Tf
	 4Vy2AT4i5+sVT7IKSkWoZ/FKvjTqEyVO4jvz0hkcPVUNIpXwzD7vMN5nPAQq/mKLbx
	 tbzq/7ztCebDp5wz19MK5YaGbMFgTKWPlMEszoDUqM9DNRkyG+K72foNDNas6iWYg/
	 pGD8Jy3jpqf5Q==
Message-ID: <78a8f06c-da93-4ade-bc69-872aac644724@gaisler.com>
Date: Tue, 27 Jan 2026 15:06:55 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/15] can: grcan: Add CANFD TX support alongside
 legacy CAN
To: Marc Kleine-Budde <mkl@pengutronix.de>
References: <20260122121038.7910-1-arun.muthusamy@gaisler.com>
 <20260122121038.7910-14-arun.muthusamy@gaisler.com>
 <20260123-berserk-crocodile-of-champagne-49d2b0-mkl@pengutronix.de>
Content-Language: en-US
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 mailhol@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-can@vger.kernel.org
From: Arun Muthusamy <arun.muthusamy@gaisler.com>
In-Reply-To: <20260123-berserk-crocodile-of-champagne-49d2b0-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[gaisler.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gaisler.com:~];
	TAGGED_FROM(0.00)[bounces-6312-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_DKIM_PERMFAIL(0.00)[gaisler.com:s=simplycom2];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arun.muthusamy@gaisler.com,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gaisler.com:email,gaisler.com:url,gaisler.com:mid]
X-Rspamd-Queue-Id: 0717095553
X-Rspamd-Action: no action


On 1/23/26 15:25, Marc Kleine-Budde wrote:
> On 22.01.2026 13:10:36, Arun Muthusamy wrote:
>> Include CANFD TX support with the legacy CAN support, enabling
>> support for extended data payloads to provide higher bit rates.
>>
>> Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
>> ---
>>   drivers/net/can/grcan.c | 102 +++++++++++++++++++++++++++++-----------
>>   1 file changed, 74 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
>> index 9fc18064fab1..508ad5320cff 100644
>> --- a/drivers/net/can/grcan.c
>> +++ b/drivers/net/can/grcan.c
>> @@ -174,6 +174,7 @@ struct grcan_registers {
>>   #define GRCAN_IRQ_DEFAULT (GRCAN_IRQ_RX | GRCAN_IRQ_TX | GRCAN_IRQ_ERRORS)
>>
>>   #define GRCAN_MSG_SIZE		16
>> +#define GRCAN_CLASSIC_DATA_SIZE 8
>>
>>   #define GRCAN_MSG_IDE		0x80000000
>>   #define GRCAN_MSG_RTR		0x40000000
>> @@ -195,6 +196,10 @@ struct grcan_registers {
>>   #define GRCAN_MSG_OFF		0x00000002
>>   #define GRCAN_MSG_PASS		0x00000001
>>
>> +#define GRCAN_MSG_EID_MASK      GENMASK(28, 0)
>> +#define GRCAN_MSG_BID_MASK      GENMASK(28, 18)
>> +#define GRCAN_MSG_DLC_MASK      GENMASK(31, 28)
>> +
>>   #define GRCAN_BUFFER_ALIGNMENT		1024
>>   #define GRCAN_DEFAULT_BUFFER_SIZE	1024
>>   #define GRCAN_VALID_TR_SIZE_MASK	0x001fffc0
>> @@ -227,6 +232,9 @@ struct grcan_registers {
>>   #define GRCANFD_FDBTR_PS2_BIT 5
>>   #define GRCANFD_FDBTR_SJW_BIT 0
>>
>> +#define GRCAN_TX_BRS  BIT(25)
>> +#define GRCAN_TX_FDF  BIT(26)
>> +
>>   /* Hardware capabilities */
>>   struct grcan_hwcap {
>>   	/* CAN-FD capable, indicates GRCANFD IP.
>> @@ -1218,6 +1226,13 @@ static void grcan_transmit_catch_up(struct net_device *dev)
>>   	spin_unlock_irqrestore(&priv->lock, flags);
>>   }
>>
>> +static int grcan_numbds(int len)
>> +{
>> +	if (len <= GRCAN_CLASSIC_DATA_SIZE)
>> +		return 1;
>> +	return 1 + ((len - GRCAN_CLASSIC_DATA_SIZE + GRCAN_MSG_SIZE) / GRCAN_MSG_SIZE);
> This looks strange, what is calculated here? Why is "<=
> GRCAN_CLASSIC_DATA_SIZE" a special case?

grcan_numbds() calculates the number of buffer descriptors needed based on the data length.
The condition "len <= GRCAN_CLASSIC_DATA_SIZE" addresses cases where the data length fits within a one buffer descriptor.
For data lengths greater than "GRCAN_CLASSIC_DATA_SIZE", it computes additional descriptors needed.


-- BR, Arun Muthusamy Software Engineer Frontgrade Gaisler T : +46 (0) 
700 558 528 arun.muthusamy@gaisler.com Frontgrade Gaisler AB, Kungsgatan 
12, SE-411 19 GÖTEBORG, Sweden. +46 (0) 31 775 8650, www.gaisler.com 
<http://www.gaisler.com>



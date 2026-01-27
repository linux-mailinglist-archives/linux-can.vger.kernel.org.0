Return-Path: <linux-can+bounces-6314-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEJUFwDKeGmNtQEAu9opvQ
	(envelope-from <linux-can+bounces-6314-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 27 Jan 2026 15:21:52 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C4090958C7
	for <lists+linux-can@lfdr.de>; Tue, 27 Jan 2026 15:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFBA03021E71
	for <lists+linux-can@lfdr.de>; Tue, 27 Jan 2026 14:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C405C3587DA;
	Tue, 27 Jan 2026 14:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="F5DfoJrh"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4294F357A55;
	Tue, 27 Jan 2026 14:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769523484; cv=none; b=o+wgVwBIQjgwSKryhu7cDj7SABfS78sybagkcvbhbabs79CXhp1bDE5sGAPar62VPsVgrEjpESLZyBQ2BH1TFk5EXpMJVkhV0x0jdl6wWd8Jc8xWjDhtN271V2XLohU3g2JfF/oZeUl+z8DJEdjY17WMqLQtNTg7+Q4sthBWL10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769523484; c=relaxed/simple;
	bh=ktOnj4bYmXFgrl9PcVTZOctVRfJ5msuGT5aar5cS5lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=tTmD3OF/oighLBVejxXpPlxfF+IBl6strHp68zR6KoEGpWHAGNSXfJR7qmwiryKzuQ6y0Is2883L5FV1j+/AoLNNJ2HDz/QgWT7bkYmKtUIXu3XTWXzpg5GrLRiysLv/FR4pY3s97Ey3wRgJUsnjXbsO5Dyl0yQuep6cCEhzKnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=F5DfoJrh reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4f0nYg2kclz1FRly;
	Tue, 27 Jan 2026 15:17:59 +0100 (CET)
Received: from [192.168.0.5] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4f0nYf6Xl4z1DPkH;
	Tue, 27 Jan 2026 15:17:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1769523479;
	bh=nxURkv6mNnP24r8iMsuXhGf6nZZ1aFBYA/xOGjuPwVo=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To;
	b=F5DfoJrhQxWtwO4+nY7XtcrakBdK51/fImdaNDqJZOGiL5zgvQldW144admEtjJ8R
	 c/pXvU3usCmQnnwlvktyaeEff1FDjeD3Hg6RW9LleT3MB4YXXFwOX+9GY2DqcfL8En
	 noAXM61SDOK3cZqV3wJeJvENxbULPLn7HPrUhiPEgDbDLrjjLEGk9y+Ge++VMsq8w2
	 ojM4sGmc2pZwaXxuPjWrALeADqDre3hB6dP9qs2zPI8tgah2K7pKNVekXWk6ehb6g2
	 7M32elK5nMhbYMrAT27T+VAguzNL7JqBWeect2YioUbU6yOHWyrAjyhFQdtcSPiB1s
	 QNlOqm5ttqxwA==
Message-ID: <99495edc-83aa-4427-89dc-bbeb0faac72f@gaisler.com>
Date: Tue, 27 Jan 2026 15:17:58 +0100
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
 <78a8f06c-da93-4ade-bc69-872aac644724@gaisler.com>
 <20260127-fancy-fast-bird-e7c4c3-mkl@pengutronix.de>
Content-Language: en-US
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 mailhol@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-can@vger.kernel.org
From: Arun Muthusamy <arun.muthusamy@gaisler.com>
In-Reply-To: <20260127-fancy-fast-bird-e7c4c3-mkl@pengutronix.de>
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
	TAGGED_FROM(0.00)[bounces-6314-lists,linux-can=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[gaisler.com:email,gaisler.com:url,gaisler.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C4090958C7
X-Rspamd-Action: no action


On 1/27/26 15:12, Marc Kleine-Budde wrote:
> On 27.01.2026 15:06:55, Arun Muthusamy wrote:
>> On 1/23/26 15:25, Marc Kleine-Budde wrote:
>>> On 22.01.2026 13:10:36, Arun Muthusamy wrote:
>>>> Include CANFD TX support with the legacy CAN support, enabling
>>>> support for extended data payloads to provide higher bit rates.
>>>>
>>>> Signed-off-by: Arun Muthusamy <arun.muthusamy@gaisler.com>
>>>> ---
>>>>    drivers/net/can/grcan.c | 102 +++++++++++++++++++++++++++++-----------
>>>>    1 file changed, 74 insertions(+), 28 deletions(-)
>>>>
>>>> diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
>>>> index 9fc18064fab1..508ad5320cff 100644
>>>> --- a/drivers/net/can/grcan.c
>>>> +++ b/drivers/net/can/grcan.c
>>>> @@ -174,6 +174,7 @@ struct grcan_registers {
>>>>    #define GRCAN_IRQ_DEFAULT (GRCAN_IRQ_RX | GRCAN_IRQ_TX | GRCAN_IRQ_ERRORS)
>>>>
>>>>    #define GRCAN_MSG_SIZE		16
>>>> +#define GRCAN_CLASSIC_DATA_SIZE 8
>>>>
>>>>    #define GRCAN_MSG_IDE		0x80000000
>>>>    #define GRCAN_MSG_RTR		0x40000000
>>>> @@ -195,6 +196,10 @@ struct grcan_registers {
>>>>    #define GRCAN_MSG_OFF		0x00000002
>>>>    #define GRCAN_MSG_PASS		0x00000001
>>>>
>>>> +#define GRCAN_MSG_EID_MASK      GENMASK(28, 0)
>>>> +#define GRCAN_MSG_BID_MASK      GENMASK(28, 18)
>>>> +#define GRCAN_MSG_DLC_MASK      GENMASK(31, 28)
>>>> +
>>>>    #define GRCAN_BUFFER_ALIGNMENT		1024
>>>>    #define GRCAN_DEFAULT_BUFFER_SIZE	1024
>>>>    #define GRCAN_VALID_TR_SIZE_MASK	0x001fffc0
>>>> @@ -227,6 +232,9 @@ struct grcan_registers {
>>>>    #define GRCANFD_FDBTR_PS2_BIT 5
>>>>    #define GRCANFD_FDBTR_SJW_BIT 0
>>>>
>>>> +#define GRCAN_TX_BRS  BIT(25)
>>>> +#define GRCAN_TX_FDF  BIT(26)
>>>> +
>>>>    /* Hardware capabilities */
>>>>    struct grcan_hwcap {
>>>>    	/* CAN-FD capable, indicates GRCANFD IP.
>>>> @@ -1218,6 +1226,13 @@ static void grcan_transmit_catch_up(struct net_device *dev)
>>>>    	spin_unlock_irqrestore(&priv->lock, flags);
>>>>    }
>>>>
>>>> +static int grcan_numbds(int len)
>>>> +{
>>>> +	if (len <= GRCAN_CLASSIC_DATA_SIZE)
>>>> +		return 1;
>>>> +	return 1 + ((len - GRCAN_CLASSIC_DATA_SIZE + GRCAN_MSG_SIZE) / GRCAN_MSG_SIZE);
>>> This looks strange, what is calculated here? Why is "<=
>>> GRCAN_CLASSIC_DATA_SIZE" a special case?
>> grcan_numbds() calculates the number of buffer descriptors needed based on the data length.
>> The condition "len <= GRCAN_CLASSIC_DATA_SIZE" addresses cases where the data length fits within a one buffer descriptor.
>> For data lengths greater than "GRCAN_CLASSIC_DATA_SIZE", it computes additional descriptors needed.
> What happens if "len = GRCAN_CLASSIC_DATA_SIZE + GRCAN_MSG_SIZE"?
>
> | return 1 + ((len - GRCAN_CLASSIC_DATA_SIZE + GRCAN_MSG_SIZE) / GRCAN_MSG_SIZE);
>
> = 1 + ((GRCAN_CLASSIC_DATA_SIZE + GRCAN_MSG_SIZE - GRCAN_CLASSIC_DATA_SIZE + GRCAN_MSG_SIZE) / GRCAN_MSG_SIZE);
> = 1 + ((                          GRCAN_MSG_SIZE -                         + GRCAN_MSG_SIZE) / GRCAN_MSG_SIZE);
> = 1 + 2;
> = 3
>
> Is this correct?
>
Thanks for pointing out.
That's not correct. It will be addressed in the next patch series.

-- 
-- 
BR,

Arun Muthusamy
Software Engineer
Frontgrade Gaisler
T : +46 (0) 700 558 528
arun.muthusamy@gaisler.com

Frontgrade Gaisler AB, Kungsgatan 12, SE-411 19 GÖTEBORG, Sweden.
+46 (0) 31 775 8650, www.gaisler.com



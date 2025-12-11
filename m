Return-Path: <linux-can+bounces-5851-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AF7CB558A
	for <lists+linux-can@lfdr.de>; Thu, 11 Dec 2025 10:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDC8B300B29E
	for <lists+linux-can@lfdr.de>; Thu, 11 Dec 2025 09:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB54528467C;
	Thu, 11 Dec 2025 09:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="J7Pc+UjQ"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D531C3F36;
	Thu, 11 Dec 2025 09:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765444820; cv=none; b=DJdD8zZ7QVBiIofDJ3ENdZNwm37ecSNW71h/WpEph8mmJggZada50CsSeTKkgdYuX0M3Fk9f+saF7jplgljDl5uQIpASQ+MicwpOdWALQbRWbiQ259/qi8XtWV4E7t1OzWMq9vbEMPAgpWPsSqssQDOioQF6ZEbbCYLyqTz8/Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765444820; c=relaxed/simple;
	bh=nzviFtLK5l+zZ9O9Z2jT+irEn9c1cX70YfPmQZaUWh0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=nXb2ZDoyyNwnvU/u5i43I1LHhn/M/pU5ARtPg0LqXQsegljPc0ezR7mnn3aYcr2/janzxTcyGW4cU+CTBCGuSafQTUrx3wRL7g1e9mJCbG4yw99B2RUKxLgveAizLzb5/MHnONiqMQmYeHQBdiFu14jHIukAuw41iWxPFZR5CY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=J7Pc+UjQ reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4dRn1l2bs7z1DDB7;
	Thu, 11 Dec 2025 10:13:15 +0100 (CET)
Received: from webmail.unoeuro.com (webmail.unoeuro.com [94.231.108.230])
	by smtp.simply.com (Simply.com) with ESMTPA id 4dRn1l1CXhz1DLXN;
	Thu, 11 Dec 2025 10:13:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1765444395;
	bh=is2tbS59QKKkJQ+llMCfR4QBx1YlnuAxAWBkhwggy4k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=J7Pc+UjQTbOzxnLkTbPOCAOFwl9+tquEvQL7sb+MbcHey+0TETkPGIGfbNhy62cEQ
	 qkP/scEPyoVr4vv8Ac5a5iB/RUBt5MK7L9eOhau4URNkimdPJiPDPGldz9fJR75lQs
	 kNAN7mPiDRGPKkrX+/I9A8E+cIJ001JLam/cwrBk+EbHA8KdwxG3EK40jacCN6LyBv
	 3m4w/1YNg+1aMMyEIfOk7SRFspHj8MjHMLdiEM5vxXeWGy2VO/lmUufDO/WXW4RQcH
	 sWnKJ3bLTdYqaKlZWtasEWP+uCZ57Drf12fRY0llP56qprYTTFUUrlsF1xEzQTbZJt
	 ieoC96AizP4FQ==
Received: from h-98-128-223-123.NA.cust.bahnhof.se ([98.128.223.123])
 by webmail.simply.com
 with HTTP (HTTP/2.0 POST); Thu, 11 Dec 2025 10:13:15 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 11 Dec 2025 10:13:15 +0100
From: Arun Muthusamy <arun.muthusamy@gaisler.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 mailhol@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, Daniel Hellstrom
 <daniel@gaisler.com>
Subject: Re: [PATCH 08/10] can: grcan: Add saving and restoring of CAN FD
 baud-rate registers
In-Reply-To: <20251121-daft-vigorous-leech-7719b8-mkl@pengutronix.de>
References: <20251118092115.3455-1-arun.muthusamy@gaisler.com>
 <20251118092115.3455-9-arun.muthusamy@gaisler.com>
 <20251121-daft-vigorous-leech-7719b8-mkl@pengutronix.de>
User-Agent: Simply.com webmail
Message-ID: <7b5a723711c7a3045e68246effd806b0@gaisler.com>
X-Sender: arun.muthusamy@gaisler.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

Thank you for your suggestion.

 From the design point of view, I prefer to retain the "do_set_bittiming" 
callback to maintain flexibility in adjusting baud rates by the 
framework. Since CAN and CANFD configurations differ as they use 
different registers for timing configuration and Specifically, the 
timing configuration is closely tied to the reset logic only in 
scenarios where the baud rate for CANFD is stored in a register. This 
differentiation is not applicable to CAN timing configuration, as CAN 
and CANFD are handled differently.

-- 
BR,

Arun Muthusamy
Software Engineer
Frontgrade Gaisler
T : +46 (0) 700 558 528
arun.muthusamy@gaisler.com

Frontgrade Gaisler AB, Kungsgatan 12, SE-411 19 GÖTEBORG, Sweden.
+46 (0) 31 775 8650, www.gaisler.com

On 21.11.2025 13:50, Marc Kleine-Budde wrote:
> On 18.11.2025 10:21:13, Arun Muthusamy wrote:
>> From: Daniel Hellstrom <daniel@gaisler.com>
>> 
>> While reset the GRCAN baud-rates are preserved, since GRCANFD has the
>> baud-rate in different registers we need to add saving of those
>> registers too.
> 
> What about removing the do_set_bittiming callback
> 
> 	priv->can.do_set_bittiming = grcan_set_bittiming;
> 
> and calling grcan_set_bittiming() explicitly after the reset?
> 
> regards,
> Marc


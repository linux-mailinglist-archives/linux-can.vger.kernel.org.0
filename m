Return-Path: <linux-can+bounces-1960-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C176C9C41F0
	for <lists+linux-can@lfdr.de>; Mon, 11 Nov 2024 16:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7948B1F24FF3
	for <lists+linux-can@lfdr.de>; Mon, 11 Nov 2024 15:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5D31A4F02;
	Mon, 11 Nov 2024 15:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="piMwN90r";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="1H+ZKwky"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD50A14B962
	for <linux-can@vger.kernel.org>; Mon, 11 Nov 2024 15:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731339184; cv=pass; b=iVSw520XZfhHC+rfz4ZvYNObwKUAx0UCG6i9X1fpd3t6aEcbfkrMHBPMWfzq2Ue0hrycfIZcvRlwUmrn0R6D8xwqqpaqhCzkuLU19Ceu0dzdA/zC4XTrqnRjBXMp6DJ5m6ZqXWYLshQcafkIHsCuoJrHaPu6W+2gj8EaDvgmLbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731339184; c=relaxed/simple;
	bh=RXXg26CkbN/kU7FfeJT0znTAQBMbico4Ogmz3UlbKUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y+NXbSeUjxahTV366WkXrfYxlUQPkCcDnjJ/a8YWXhDs8AsQEXqeN0gTStdhYzI/G3rZFI+izRrQm9AvLGwlQQuu0Uw7gW2lfb9egS131jz3DMYyB064XHi9ZAFgW/LMl3w7nEryx7OhifFfWIKOhTsD7yEnwAqMSksCYdSDjBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=piMwN90r; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=1H+ZKwky; arc=pass smtp.client-ip=85.215.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1731339172; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Th+AMBONapcdw8E2o/Zxktqzj34jZWIaeENWEvewUznpe8qgTjMBOuorpwi2xsG+rl
    jB/6B8vIwqAwn7zV4QfVft9/5Ndvos3z/LAYCzlSJ5JK7YoM0rBL0tPEL3DPoTm++J29
    fr+/4QM/a+ppUVt2htGHiSwJunNA6QMRXsTAVNxifwUA3SnRxjsJsN5B+SChyZzq0/Pd
    cF5g6G1QwliPaEiDPqyM69XeA6qEfirF1fp1pPHmbqzAwoitfnTXJ056cvtiwRyxL0YZ
    ymStTpMwX2Wjs5QBmuCdxPfs4W2mptAgp1SeBOR8EG5pcJNmsVsiVGuU1QEaAuWtCpWf
    A+XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1731339172;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=N6qflJC0WngFCp68pmCyDOqjHZ7TuFG4J1Kl8Jn6bWE=;
    b=UQOBBVvBldMWBhUvzzASn8xBCBuxPTzFweJIasveI9zVVlc5vvofJiHChAVbHa7mCe
    Nggl1lbkOBHfOJUzekB+cxhCEl1Na2oFNoOZRIDTg0yq9/5jW8gFHCxzd0t3FWuVvVgD
    fucjHElh3SLsT3hKQ7I5p7/2E1PCFBcuwVKdR6iUztU3MahwhHeV5UINgsQ5Yk7b+TlD
    +qP/dijN2+4gLMLJGgLYWCMp0j4vfhpfApwvjUrV3bD4QiAJPOG49QLGmor1Nxnvzptm
    CJe96+mhfH9W3jNJa9hlxTtngPFJi8whbtgQ1ch4IcOqRs17QElPne/zHumr58+j5E9f
    yOXw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1731339172;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=N6qflJC0WngFCp68pmCyDOqjHZ7TuFG4J1Kl8Jn6bWE=;
    b=piMwN90rG/dl6K7FHBoqT/dFFujOhR11UpuMvCyE7KBv95O2kU5VPwmYGp8ACP3elu
    14pLsT+ALNgBLK9MH7cLUGo8rdr/JY8ye9kWlQh8GeklQQxKiONJH+8dNfJxeR2VYbsk
    0JsNP/arqRkwW0ceKZIn71q81pNQmawpxvEpFZXWATd3AkDfZPZZNF50LYuhVC+UB5Qj
    G8iI+v9KqESrKEwD6PPJoLbBPkbCU3ZhoCgLFL1gtpLABQRFj1wYStFjVenXwq+8vpYH
    a3VzKsosv5NgLfYndlfjBr/GM1HIKIEbpYBsQz1Q8vveH5n3CpAFz3185MCPFffc9QPr
    rFFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1731339172;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=N6qflJC0WngFCp68pmCyDOqjHZ7TuFG4J1Kl8Jn6bWE=;
    b=1H+ZKwkyOn+IodCPbclYhNHdSO4xLkkhqyvamccTNSvb0N2UgvB4jcBhGuP5vN9bnk
    l57N0D34Fg33CiBogSCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+5xtv9aJ67XA=="
Received: from [IPV6:2a00:6020:4a8e:5000::9f3]
    by smtp.strato.de (RZmta 51.2.11 AUTH)
    with ESMTPSA id K63ada0ABFWp8PU
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 11 Nov 2024 16:32:51 +0100 (CET)
Message-ID: <23c914cf-0af2-4619-9f83-e4b6339ef65f@hartkopp.net>
Date: Mon, 11 Nov 2024 16:32:51 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/14] can: netlink: add CAN XL
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, linux-can@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Robert Nawrath <mbro1689@gmail.com>
References: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr>
 <ea52eb8f-c59d-445a-bf4d-26f2772f7426@hartkopp.net>
 <a9d8eb65-c88d-4bc9-b0c2-c0e0799ea5bd@wanadoo.fr>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <a9d8eb65-c88d-4bc9-b0c2-c0e0799ea5bd@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11.11.24 16:17, Vincent Mailhol wrote:
> On 11/11/2024 at 23:08, Oliver Hartkopp wrote:
>> Hello Vincent!
>>
>> Very impressive! Thanks for the effort.
>> Together with the example in the dummyxl driver it should become quite 
>> easy to integrate the netlink API into my XCANB driver hack for testing.
>>
>> Picking up the dummyxl driver I wonder if it would make sense to 
>> mainline this driver probably as can_nltest driver?!?
>> Of course this driver should be disabled or combined with some kernel 
>> testing Kconfig stuff. But is it a great testing tool.
> 
> Thanks. I do not recall similar things in the netdev subtree. I wonder 
> what would be the idiomatic way to introduce such netlink test driver.
> 
> @Marc, any thoughts on this?
> 
>> From what I can see with the bitrate and tdc configurations the 
>> extension for CAN XL is ok.
>>
>> If you take a look at this manual
>>
>> https://github.com/linux-can/can-doc/blob/master/x_can/ 
>> xcan_user_manual_v350.pdf
>>
>> on page 268/304 you will find the PWM configuration which consists of 
>> three values with 6 bits each. I assume this to be similar in all CAN 
>> XL controllers.
>>
>> The PWM feature switches the physical layer for a CAN XL transceiver 
>> in the CAN XL data phase. This is a weird feature to do some PWM on 
>> the controllers' TX data pin to be able to switch the physical layer 
>> while maintaining the CAN transceiver package with 8 pin layout.
>>
>> Additionally to this PWM configuration register, the PWM CAN XL 
>> transceiver switch feature has to be enabled similar to the way we 
>> enable 'fd on' or 'xl on' today.
>>
>> You can see this bit called XLTR in the Operating Mode section on page 
>> 269/304 and 270/304 .
>>
>> E.g. that might be named 'xltrx [on|off]' (default off)
> Thanks for the information and the link to the documentation. I will 
> also try to see what ISO 11898-1:2024 has to say on the topic. Just be 
> patient on this and do not worry if I give no signal for a couple weeks.

No problem! I will give some feedback when I managed to integrate the 
extended netlink API to my driver.

Maybe Robert also gets his hands on this, so that we can continue to 
discuss things even when you are busy for some time.

Best regards,
Oliver



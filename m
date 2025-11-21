Return-Path: <linux-can+bounces-5559-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 18699C78339
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 10:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9635B3449E2
	for <lists+linux-can@lfdr.de>; Fri, 21 Nov 2025 09:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0964433F8C6;
	Fri, 21 Nov 2025 09:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ojVtJJ+2";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="j0uYIwJQ"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4D7306B00
	for <linux-can@vger.kernel.org>; Fri, 21 Nov 2025 09:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763718048; cv=pass; b=PfQR6qsC/ejaI6bQzQLqkMG0ysYZQloWCXvvY+sA62VIhS+9ctYy6Rv4XG+tYubO1dxTQYHzji57JQKNxspv5H/2dMWpXpmvx1aqk5Ft/zp9H9dim9GxsuYHTTn+OUoajYVEWZA0zo4LpZm5NLx+dM16nEomXuYYidvvtRcGBGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763718048; c=relaxed/simple;
	bh=NJqutpjJGlXTaVtOOXbBrFY5cLjeY7kBqBhG0FYZPCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UYpuZhJs3/vWE3dZYDciqi62eoluSUxKEWQZGBra6q/qlmLBtl6y1DJyumaIGjisheC/bawqoyCStstuRx0qQJHJ5+t+Pvm9B+827ZV5fyayCSTWfJPQ40Kv8HiFaS0kNIOb/CdXOxKcW+r9BNFewORINpR+MnM/epTo2+6gGM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ojVtJJ+2; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=j0uYIwJQ; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763718040; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=L9JVmbfN+kOKOAJazzxqITu2aoxNwU58LZLlEFSqXGhUHOgCNOkv7SZPAH9w15QNGK
    JoGU0prONc64ZjraMZKmuQhV+NrxLmr3QljhUVbFzEGWJcxaQx+RsQP2WytiCsjCrzrL
    +X6hdqDhmbMbn9JCIAXc7f1Jp8UzJ5nqwdB/Bl4P03DzU0TYI/9aRfneVYX+9kY6rqRX
    h0Qf1B7jH+BkAsqnLJtWrphEMd40ARg3nclW0J4jaqVa08r7GlpDvhmkCHPN9X+TE/Pa
    ZBGHtPWO6yso1payUha1OrDzD6ybfK2pK65v5aXb64T30dyO0qboNX5iHYqpMoq9leMq
    +qYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763718040;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=wQIasBlHM6JpsZ4STk6qSxjLtZabnPl0SFKsChS4J9M=;
    b=L0hJsIokwmvrwRSv3S+oc7tuF/mf+ouOcLec5Qun0yD/LQIkreBWba+e2U2GLKwsp4
    U4XO5R7pP4NT2YWFgH6XJ5ezKrJHz9YIxAphjpcExjgasldWz16v4L+oTQy716hvz/EM
    EWqneM1U2CXeA7/ydzNlApC1fIMBrGS9zVFXo+yU7AOX2gNwOZLIUPWDe4m/jg6j3uF7
    /OpKU49/SPxNNVYRcc4L6Cjpp7lczIZP/Erv7kKD+jDt7pdBHwzx3pp/xFzPRIpgulCh
    MJ6ysG6lQ3UC7E0dUFSMwgplEI5bNW95Ef2YpliIZyZkBySyj9m9ZozNPlY+tD+rhbYE
    L2vA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763718040;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=wQIasBlHM6JpsZ4STk6qSxjLtZabnPl0SFKsChS4J9M=;
    b=ojVtJJ+2V3L75rcDt1vV+iVztJMoWVxtHp89LDIwWXqy3Pj3w6YBgNnPPUUO3cxyz+
    hgvTO5RqNeTqEFP9v034aBFjlCK+NhnaEtF0zbNKujHIhseWieNNwQYn55oHcmLpecxT
    Er/4X80FNIkmaszY7eMveZhS/+5fCvqYI1c0wt1TwZJQByGSlhuo4udPYOXAIup4mjhv
    LIPvaOI8I8zu84HPgyzUsi9g7xf03zBaqL0pYfeXBUEzIMAtjGDXgbYsC3iDZ5zeji29
    2GF0IbGuT8/sOEj2M774IClsGht1wugNfPD0em3okpBLq9OpzCYu2/8Ty1WTiA7yXHhc
    HeyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763718040;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=wQIasBlHM6JpsZ4STk6qSxjLtZabnPl0SFKsChS4J9M=;
    b=j0uYIwJQ7vrQjfscLqcGBFhemRnoOqMjENzKEyMMkxhJlHUgaWboVzqGnjfo2zV2bB
    JgAwAR7Dya1ZjYWDETAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AL9eeBXx
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 21 Nov 2025 10:40:40 +0100 (CET)
Message-ID: <5020fe6d-aebc-40ae-8067-eeef4ea4c9cc@hartkopp.net>
Date: Fri, 21 Nov 2025 10:40:39 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [canxl v4 16/17] can: dev: can_get_ctrlmode_str: use capitalized
 ctrlmode strings
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org,
 Stephane Grosjean <stephane.grosjean@hms-networks.com>
References: <20251121083414.3642-1-socketcan@hartkopp.net>
 <20251121083414.3642-17-socketcan@hartkopp.net>
 <20251121-meticulous-authentic-hippo-a88adc-mkl@pengutronix.de>
 <c16bbec8-f4ad-4eb6-9e0f-362c3e6261df@hartkopp.net>
 <20251121-neon-wildebeest-of-contentment-fbad44-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20251121-neon-wildebeest-of-contentment-fbad44-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21.11.25 10:30, Marc Kleine-Budde wrote:
> On 21.11.2025 10:19:39, Oliver Hartkopp wrote:
>>> Here the prefix "XL-" is dropped. Was that intentional?
>>
>> Yes. The patches for iproute2-next and for the kernel are inconsistent.
>>
>> The command line (and its help text) uses:
>>
>> [ tms { on | off } ]
>>
>> The ctrlmode is named:
>>
>> CAN_CTRLMODE_XL_TMS
>>
>> And the output of 'ip -det -link show can0' currently prints:
>>
>> can <XL,XL-TMS> state STOPPED restart-ms 0
>>
>> Which needs to be changed to <XL,TMS> IMO.
> 
> That's iproute2, it can be patched later.
> 
>> I think 'tms' is better in the command line than xl-tms as it is clear that
>> tms only works with XL-only and if you try it otherwise you get an error.
>>
>>>>    	case CAN_CTRLMODE_3_SAMPLES:
>>>> -		return "triple-sampling";
>>>> +		return "TRIPLE-SAMPLING";
>>
>> There's not always a 1:1 name mapping.
>>
>> IMO CAN_CTRLMODE_XL_TMS together with "TMS" looks fine for the internal and
>> external representation.
>>
>>> We should move this patch to the front, so that new members could be
>>> added in uppercase from the beginning.
>>
>> This is a useless effort IMO.
> 
> It's really bad practice to change things in a series that has been
> added in the same series. If you don't want to do it, I'll do that.

No, it's ok.

Will do.

Best regards,
Oliver

> 
>> When we decided to unify the capitalization as a clean-up four weeks later
>> (what we did) than the patch sequence would look like this in the tree.
> 
> As long as you mean "upstream tree" - yes.
> 
> Marc
> 



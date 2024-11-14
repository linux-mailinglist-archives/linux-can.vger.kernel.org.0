Return-Path: <linux-can+bounces-2036-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F7A9C85AF
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 10:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79016282BFA
	for <lists+linux-can@lfdr.de>; Thu, 14 Nov 2024 09:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE3D1DED57;
	Thu, 14 Nov 2024 09:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="KCQ6HkZZ"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598121DC720;
	Thu, 14 Nov 2024 09:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731575430; cv=none; b=kz+x8sOxHLQmuNAA14TiMT9KWTMl0mB3nsxCEN7O2AcP8TxXNnAnmEdlVUMIqWPtS5P+S6gGJkAQFC8yMt06oXXB2Ka0XZOit6EdHspJYcXeR25Osx3TyGFfQYWF0nd9HJK3cpHr4Ae3kInQAwH3u9ZoD8T0HfkQpeat8q/m958=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731575430; c=relaxed/simple;
	bh=qi459wfvFsnS832kvtdxzS+EEsn4sCYuCfP79o+GGxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tfssYUvzsz7E+jwUcVKFOawQ+d9qTDGT7lwMW2STN3Ygbzrg1paZEOKYUl4IsOo77vkJC20kc5OE5HkEcdhZccYl8gbMEALTE1pKboxHGuackyTe66L8A2pnscgBETfNVdL/hPxQlBolhXvECnboRoDWzc2RViH+Iv8WxPWEuRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=KCQ6HkZZ; arc=none smtp.client-ip=80.12.242.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id BVrltGzWcAYYWBVrptXEZW; Thu, 14 Nov 2024 10:10:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731575426;
	bh=uoiq2Jhl3yg73iU+ycL9CzjyiBUiLtExH1jNdAS/ufs=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=KCQ6HkZZ4ZgGhJnvJEfHVzjS4f1omI676QivxrpqCvgUC9GqG5mMIGbXkIEICCghR
	 aHn9wAkTyTEQEhMIIJmRIPF7mJCiKxjLOe56dPHkOPvRIVRQ6C3AxkCB8IIEEVDB0u
	 jEBTlWPuBJktqMQhgO9Vo/V39L0bS0vSlPmxBkopkp1hV0QJOfbycR2MkETTQdGsvA
	 CrR7VevTZI/VfXJXCECk/9ekihJeRIlI+HT+lpDN6Z/w7GNLjhSNDMHo7ftf9QGbh1
	 RkcMUQcr/R7bcr9E3Nlpmh1O6irwIK0B2bi2Yn6I6r2RVLc88JgV4ufDhlrLajJvcw
	 SbDsKJsd6rcwg==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 14 Nov 2024 10:10:26 +0100
X-ME-IP: 124.33.176.97
Message-ID: <6961dc9c-51bd-4430-ba32-80303e2e3027@wanadoo.fr>
Date: Thu, 14 Nov 2024 18:10:15 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] can: tcan4x5x: add option for selecting nWKRQ
 voltage
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>, Sean Nyekjaer <sean@geanix.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20241111-tcan-wkrqv-v2-0-9763519b5252@geanix.com>
 <20241111101011.30e04701@kernel.org>
 <fatpdmg5k2vlwzr3nhz47esxv7nokzdebd7ziieic55o5opzt6@axccyqm6rjts>
 <20241112-hulking-smiling-pug-c6fd4d-mkl@pengutronix.de>
 <20241113193709.395c18b0@kernel.org>
 <CAMZ6Rq+Z=UZaxbMeigWp7-=v5xgetguxOcLgsht2G56OR1jFPw@mail.gmail.com>
 <20241114-natural-ethereal-auk-46db7f-mkl@pengutronix.de>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
In-Reply-To: <20241114-natural-ethereal-auk-46db7f-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/11/2024 at 18:03, Marc Kleine-Budde wrote:
> On 14.11.2024 13:41:12, Vincent Mailhol wrote:
>> On Thu. 14 Nov. 2024 at 12:37, Jakub Kicinski <kuba@kernel.org> wrote:
>>> My bad actually, I didn't realize we don't have an X: entries
>>> on net/can/ under general networking in MAINTAINERS.
>                        ^^^^^^^^^^^^^^^^^^
>>>
>>> Would you mind if I added them?
>>
>> OK for me. I guess you want to add the exclusion for both the
>>
>>    CAN NETWORK DRIVERS
>>
>> and the
>>
>>    CAN NETWORK LAYER
>>
>> entries in MAINTAINERS.
> 
> I thinks, it's the other way round.
> 
> General networking gets an X: for driver/net/can and driver/can/ and the
> include files.

Indeed. Now that you say it, makes perfect sense.

@Jakub, similar to Marc, feel free to add my Acked-by tag when you send 
such a patch.


Yours sincerely,
Vincent Mailhol



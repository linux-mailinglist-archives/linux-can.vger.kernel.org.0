Return-Path: <linux-can+bounces-4501-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90659B4795E
	for <lists+linux-can@lfdr.de>; Sun,  7 Sep 2025 09:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C2ED7B2829
	for <lists+linux-can@lfdr.de>; Sun,  7 Sep 2025 07:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DFF1E32BE;
	Sun,  7 Sep 2025 07:42:42 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055B412D1F1
	for <linux-can@vger.kernel.org>; Sun,  7 Sep 2025 07:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757230962; cv=none; b=SqI0WZeS77EnYBRUJGXhW2PiOhK2HHiXgBe2v/UEUGMr96nHv3eivTuOZK9ZYamhkjQNfDlfBhGG5HLcTH3u+HGUxUr2p6+i+/FzGpvelRvxKmI4b0q9z+V259USDcJSmNgS84HcCBGf9gixUB7NgQ17f5Og3oX8X5Rq7vkO3ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757230962; c=relaxed/simple;
	bh=Q+VhqqLC2lb2J2kSv/TcxB9YQWvzigAbMzcbNLDqTOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pdEhW+PcWFitnS0aMxPBMVYOWVnW8BeICZToSYpwkjtTgnZAsH8PiE9zKp/5+pSPhRUBr/roHC3ZLvx2YVEF7W68GoZRb7XbmX994VGBCnkXoGD6BHqZM8H8p+N/lvCd2sHTK8So5yl1TJDCHh7+KcjjV0KaI6485ZzzioLFqMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 5877gXJg058373;
	Sun, 7 Sep 2025 16:42:33 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 5877gX3N058369
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 7 Sep 2025 16:42:33 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <40478f86-3de1-44c1-ba6f-6de3ed40bdeb@I-love.SAKURA.ne.jp>
Date: Sun, 7 Sep 2025 16:42:33 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: j1939: undo increment when j1939_local_ecu_get()
 fails
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: linux-can@vger.kernel.org
References: <e7f80046-4ff7-4ce2-8ad8-7c3c678a42c9@I-love.SAKURA.ne.jp>
 <aLqf0-WGRA8-Qb15@pengutronix.de>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <aLqf0-WGRA8-Qb15@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav101.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/09/05 17:31, Oleksij Rempel wrote:
> On Sun, Aug 24, 2025 at 07:27:40PM +0900, Tetsuo Handa wrote:
>> Since j1939_sk_bind() and j1939_sk_release() call j1939_local_ecu_put()
>> when J1939_SOCK_BOUND was already set, but the error handling path for
>> j1939_sk_bind() will not set J1939_SOCK_BOUND when j1939_local_ecu_get()
>> fails, j1939_local_ecu_get() needs to undo priv->ents[sa].nusers++ when
>> j1939_local_ecu_get() returns an error.
>>
>> Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> 
> Tested-by: Oleksij Rempel <o.rempel@pengutronix.de>                                                                                                             
> Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
> 
> Thank you!

Thank you for responding.
Do I need to take some action (e.g. sending to netdev@vger.kernel.org )
on these three patches?



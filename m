Return-Path: <linux-can+bounces-5772-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F3AC93E54
	for <lists+linux-can@lfdr.de>; Sat, 29 Nov 2025 14:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 367454E1BC5
	for <lists+linux-can@lfdr.de>; Sat, 29 Nov 2025 13:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28C12E7F27;
	Sat, 29 Nov 2025 13:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="XfG/umdu";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="GXISY155"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD95723ABB0;
	Sat, 29 Nov 2025 13:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764423437; cv=pass; b=MDcFsd7g2roqgKJfVJviFDk7S/e3vxb4are5cKH2uY0txUWvCxF6N2el7BCOWhvexUxZ46KP0HBsCwti4Pb1M4V5SHJCXdwlshkEBeImp05gLBo8/5GAWWvd9FsUrNr8VdHumRzzWqRoq0G4ZV8uyFCJNnRj5sYluyenJPsMExo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764423437; c=relaxed/simple;
	bh=Nqvm+8eKDFhQsWRma3qttlk2onY5yvqFcmbPxlFQGKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OO8d4YWa0fyMOm+TBpEY7uPdsLGWjt1euLuMx6me21bkTrD2iJQ+hmgYKuNn4CkzaXFS8dOmBknen3eV6nyFhoVtOnKoKcE3zYtChKbZXv9PZQ3XdzmZvD/i3b62PxERor4Sctsb3kBn5DNd9Pr3DiTj1UXzXDL8uLNZipaLY/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=XfG/umdu; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=GXISY155; arc=pass smtp.client-ip=81.169.146.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1764423414; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=pinhKtEon57rW2sNKR/tSzLQNHU6UgJykAnlvRXFfsh++gDtiSWAfEUnrKZvlidlF7
    ynHb0iRAsX//dCnjMlA3W1RnJw4xpv3yHPvrKj7kBT3K2G7AinN/nxhErnrO7IFhqO6k
    ZX6zO+lpND6li99SAEOV6LhmSPRIbLV5HGv/mIFU7yBpMcmfEIRKUtkmExIHjHi2INRF
    Gytm5o4ptIJwt62KPt7sI1igL9PQmqqYXzLiRP2sa2cuouJJ7MY6MfuAzk+S2AvDAWHc
    le+1IZ9CTADZXT976nIiqNRatAgiVDBx1DktYF63pxOJVz9eU2V7PZfqKGXI7dx5xu12
    zwbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1764423414;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=aCAiSwPD73VNdECVmnPR4OE06tOBC6TL2sMZyKjHBTw=;
    b=AiJ9r4PCCZGuVO8J6kRRBa7NQIXbgLbNu0Uh9lunFJlebh1MmvOSTzKX8vUXyTtAdy
    GFs1mSlle989hcoWPV0NMd3S3qHKHxxuiQ3lTlcn2cubhUnR9lrXG1OBDMCp4Vi/9Aou
    SRGsdP5f75QpxHZLHcSE3uu+kUNqyj/FJ2gU+Dh5eBxY5uSaVBPYHgfgD57fnNYnPOiN
    ylocImFuoTEOmBcs06OGZz89jux1Y3/HO9c37PbZryOJZQx6eUQ9wmmTQyDLHoRTyAB+
    AYlKy+NzLt8oh0wRuwSwNO4Cntsi/NcXBMbE4cgLV294Cs4Cm3qtLLNVE5e7/9kbqv3I
    SZSA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1764423414;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=aCAiSwPD73VNdECVmnPR4OE06tOBC6TL2sMZyKjHBTw=;
    b=XfG/umduxy7pQhmAAgdU0YeeQYxdm9/FSc3kWObtMc1Wc9lbFMPn/qNK1WjKj1skOi
    IfIAlIN4tWUgvvFFDbOABMWqkt2v7reMwHxafIcy+Eaj2WgV3s1YcaVK/8U4JBlFSafZ
    IujJ6vHYBCW2UJAsSvbvVPxsJSnbgxvK+nZeaBdR/fGJbIU1K+ujYn6qBLWcet/x50gN
    YOFTjC9ub8BgEqbjNbul58TRrc9S5/Onivo9ihVPJNzvO08m1d4reOLCm7lr69n/qji3
    r0pfO3SeC9ugNKp4xPcxjly7kUevvwBt+4VQC+uMJp1/JdNGZXcQq1+TLZk4RsswWVDG
    g3+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1764423414;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=aCAiSwPD73VNdECVmnPR4OE06tOBC6TL2sMZyKjHBTw=;
    b=GXISY155DZac/T2JgLv0Z7p4KZGTFhRjptmDj2tJmwhx4I2jylFOWLroCQi6RLP/tA
    OCARRxb3l6QeQX8RpOBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461ATDarjHt
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 29 Nov 2025 14:36:53 +0100 (CET)
Message-ID: <fea87139-c114-4d86-96e0-b41b2458f102@hartkopp.net>
Date: Sat, 29 Nov 2025 14:36:47 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [can-next v3] can: Kconfig: select CAN driver infrastructure by
 default
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
 kuba@kernel.org, kernel@pengutronix.de, Vincent Mailhol
 <mailhol@kernel.org>, kernel test robot <lkp@intel.com>
References: <20251129090500.17484-1-socketcan@hartkopp.net>
 <20251129-ultraviolet-sponge-of-focus-e788eb-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20251129-ultraviolet-sponge-of-focus-e788eb-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 29.11.25 13:51, Marc Kleine-Budde wrote:
> On 29.11.2025 10:05:00, Oliver Hartkopp wrote:

>> Fixes: 1a620a723853 ("can: raw: instantly reject unsupported CAN frames")
>> Reported-by: Vincent Mailhol <mailhol@kernel.org>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202511282325.uVQFRTkA-lkp@intel.com/
>> Suggested-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> Added to linux-can-next and included in my latest PR.

Thanks Marc!

BR Oliver



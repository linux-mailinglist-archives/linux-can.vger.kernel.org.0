Return-Path: <linux-can+bounces-5405-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A58B1C6043F
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 12:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 51C3A35DA11
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 11:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A942580E1;
	Sat, 15 Nov 2025 11:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="i7T7SGIP";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="XwuawMuV"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F62A2222D0;
	Sat, 15 Nov 2025 11:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763207461; cv=pass; b=jMyi9N3A+dfeZyQIqI6q2k1UcMq2BmLUPdpkf+E0pBSY80bcxJrB/Sw8UVW8q7Br5PmDrtDs8ZOY4KdicVXT2ZZj80Jvw7gH9ybbCAKJWmL5RhFqSIhHYSawcxjsoqeZ5gW5bPhDjnqRpmulWNUEG4iiRRYBF3jsdANd2qMNuU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763207461; c=relaxed/simple;
	bh=CwWYuBmqBrQ/gQnkx/bn+UuTCCzM7LeKUoHIEVgGENI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=obcoqGmPcTNVUoK9uDB4uYixedbGvuf+iL3c4fC2UpiAcHFICgxA35Wbp845rb4fOx78haZi/7Sl4mizkERYCIFXJXANcMIVpxSKoK0MFnXRoGJqhYTZpt5uTH9n8+OO3sHLZxVxeSeKb8UqVmaMy/6ztnjJEJ1aNvODg50mCLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=i7T7SGIP; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=XwuawMuV; arc=pass smtp.client-ip=85.215.255.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763207449; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ew75ATGTt7MIKFFz0CdraZ4AjYSEyBGvJswYguZH2L00fweaalGRNe1H+FlkNDzB1y
    f+edgLvhuw1cdH6+oDQCsXoull2FvvxgTBDV8yPBgvyHRxooRch9XzZDvaRAYX1UZHf3
    TceMxtH4AXH4T5MyVph1y5xozOLz3d0xtXhT7dUuhik8L502ynmHkO5qcwya8oBkqwcf
    0DdmOSGnyMHV/zsP284PlhHgzpUmrstpUvHEEM5ZsXQmlhcdBe6LVIwAahMeNRs2geUb
    xvN8jGnB8y9FGyu05bRRR18D7ZzBalAFJdqN5SRHKmBk3KwAQx0eRs42DrzLcMYxlbZG
    bEww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763207449;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=CPCJvebnkAlrNzgphNQ0j3IFUOikVqWaBpCC3u6ULrI=;
    b=f6A5ywP0H1jjScGj6DkP9U2Aiajp5xuJ5vg7sULiVNeDRIFDGSxlhaisxuOO8plQZa
    Phu5CnBS0iI4OzWYvDybZNQ+eFBC9wceJ5+SsCfSWDD8Ng2eIY1CFpgIPps2gwuPQ+1l
    RkmZhYfdmax2zQrEjuX+E+dfi/W7YCpmnJTIVq+jfWpFLqWdf3YGG/Lur/jZel3TeTJu
    Om8etnwVpZP7+vWcnq6y4onyyOYBD7coAN1IJl2JfkDNmyMaNe6oWI/KjnOyjeyeP2UD
    OgvGUGLT203DCFk06U57BfAAvATCMCFBAULCGb5KYykAWgI4Prs4I96jItUzGv1UJ3G1
    P+Nw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763207449;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=CPCJvebnkAlrNzgphNQ0j3IFUOikVqWaBpCC3u6ULrI=;
    b=i7T7SGIPhS21DSXSXpRs9CEyCE6h4/CT4ycTlEr/BRFJlVWKmxrOKFppFbHJjgh17J
    3f0CPuXtcsaoB3Mm2ZFe7/L6una4iOFl3aNu34Zd3yxR7Qir5ZlOvJPGj1wzkHJq1fFq
    bfIskc5RJBaId60pqWBS9gfv+koYqWACwDQyogpfw5X+9jpemzhTh3oXd1/aISj7Gt8k
    Kmp9yfWC0Z9HPpWva8QYEBuzau9utCX2DPiiO8rFAg411zBkTczpDr23WG1fUwMJS+Kg
    Lf6fxCYZoluY1uvJ/zOxb7ZcBB3zGPZ4J4kKSyoyhKnjPKE7t/HebevthU85R8P3Fu3H
    zjfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763207449;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=CPCJvebnkAlrNzgphNQ0j3IFUOikVqWaBpCC3u6ULrI=;
    b=XwuawMuVCzac6iznjNfYcp8TFTbFbQs2nfzKr4wKULmiMot6HMlHyqdFf3QM3dVeNV
    2qN3QfeqQn8isrU+TcBA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AFBondZf
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 15 Nov 2025 12:50:49 +0100 (CET)
Message-ID: <7e99da1d-3981-46fe-8b64-6ddd3a0c2d58@hartkopp.net>
Date: Sat, 15 Nov 2025 12:50:43 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] can: calc_bittiming: add sample point calculation
 for PWM encoding
To: Vincent Mailhol <mailhol@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251102-pwm_sample_point-v1-0-3bbea180f59e@kernel.org>
 <0065ed0a-8442-4d6d-b132-789add82ebe9@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <0065ed0a-8442-4d6d-b132-789add82ebe9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vincent,

I was not sure when you would show up again and therefore I started to 
rework the discussed points this morning

- error-signalling / mixed-mode / CANXL-only mode
- restricted mode warning removal
- TMS as a mandatory setting (now default off)

for your convenience and for an inspiration/review.

I'll send the patch set as-is without further documentation.

The PWM sample-point and CAN_RAW changes are missing.

Best regards,
Oliver

On 15.11.25 12:17, Vincent Mailhol wrote:
> On 02/11/2025 at 23:01, Vincent Mailhol wrote:
>> I wrote this series in response to Oliver's feedback in [1]. I am
>> sending this as an RFC based on top of [2] for the moment so that we
>> can discuss this separately. The plan is to merge this to the CAN XL
>> branch once we reach a consensus on this part.
> 
> I changed my mind. I will keep this as a separate series. v2 is ready locally, I
> will share everything together once the next can-xl series is ready.
> 
> 
> Yours sincerely,
> Vincent Mailhol
> 
> 



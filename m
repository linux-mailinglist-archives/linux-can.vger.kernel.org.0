Return-Path: <linux-can+bounces-4462-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D21B43326
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 09:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAF3A5835DE
	for <lists+linux-can@lfdr.de>; Thu,  4 Sep 2025 07:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397FA2C0278;
	Thu,  4 Sep 2025 06:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="dbfK9a5M";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="LfO3RmLV"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C726286412;
	Thu,  4 Sep 2025 06:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756968943; cv=pass; b=Ozdb6NHaeO0zowUVmte2M2WwDhEqDtTiuypo657MZX6jrNlTZTiJOHKTKNnhxTct8Ka/r6bV+SHCI2ErG9dQArGhmtTVFBwEAch1lrQUVrqCse2VgAoeIvPe/tSso6SQW5Zn+2vdMB/rD3uGh3bE3sV7xM5xp+vpSSTg0SwKXek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756968943; c=relaxed/simple;
	bh=bCInGNafFosv2/EfM0snbVd+AWphjz5RaQRvz2HRRWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jHukFFz/70uYr76Q4TQFMnSP6gJT8utkCUbZCNSMkAFI+7IUfHoANOSoD3nMKAB8NKkF1glyt2Amu5DkCTDQequCW7aazmeZek6A5KTeg42jSiiuGnB4O4vrIumNWezyGVcYkwb71nWOD0FA3NKXMsnhzsV6VjckCvx8y4JSSKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=dbfK9a5M; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=LfO3RmLV; arc=pass smtp.client-ip=81.169.146.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1756967139; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=jhq13UGEQj+UVTk+FWkawpup0vWB4vRosIpcfSqaHJGKkk+Dhe0og8uhEFj4d6JneY
    e+bjNgmNs4dO27TjhMBlijH9o3muPliKutXtBtJas2EHGbIXCEUE+39i0hKfkeM8GvoB
    WFxaCyW4EeWT1H2zqGlYGrZUxNoJ1P/J3f49h6P61fACrTouQG3zQQylHQ3BLjkM7ebV
    xlDkHAm5ZkT1zZMb7WwVMCPsIwVfbO6klyFMfeiYtdYydgrQSSTvcpslAuloVRrAuBM+
    K+G5Tih4IhRcnRjJ8bjdnaLmUSFcumNL/heDZDnONfJmRYt+oC1GyX4mh0Xp0WdxoTnY
    zuBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1756967139;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Et1a3Y43DomKtCR9LncztA0z4+5TKf95ey/BMZttA8Y=;
    b=YJ7Zq4RffSAYvQ4PAcODpZPt/IguDM1sVSWYL5sbpbtRhwiqmZOyjVeuTxRuyGgMPf
    xH73WxLHA+b1d1Hwy4xTDUALSA0TBosFv5ZNrvAgWJ1AOkPsKhVBxMmzR5pmluT+K83+
    lEMAZa9el1uPH8lK8FU5cbT6r+UIO9/dPbQB5yAVDj53dylYRHATUAJYGPamn34EPJeb
    Zp33XZ4ID18Fu4isdsdTFFKcDhL0fQl+l2Uq2hZ4n6POfxbw0nveNz4d8Ff1T+fnomPu
    DsviOJPSZOPpJI3fCHQ1V0rhuMDEnracpCtWPadiNVk0Qr2rDBzsgCEGSkQmctPhr/Fy
    +uMw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1756967139;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Et1a3Y43DomKtCR9LncztA0z4+5TKf95ey/BMZttA8Y=;
    b=dbfK9a5Mgo+loiwoQD9/Qn2XvVKcsbBEDCo8BQtzhJhC4Ik7MrAdQ0BPbfVsvrcom5
    VQavMhKiJJ1BVZ3rymEhPjG+uVHMigPqBvIvy4wuNqqq5Qx9v+63vxB1WFw8wPbaF6Oc
    SeyGfQwuSF6qcllQYX04K1Eo7XB2GvCJL4ts+JkO+DGrPs9KQxwpWA3YMhgFxRYnIR8D
    cVxXpVX+FbIzpIdHnFley9eEy5qvAPp4RtJk+z94ewfgEePHRou2g2OU6y+y3l/mwWLd
    GAoODfCCXqE3xpYIrBIvNTQTsVae2czBtsq9cV/3lTxKFUEvMfhOSacEFKdUZwxfv14U
    iImA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1756967139;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Et1a3Y43DomKtCR9LncztA0z4+5TKf95ey/BMZttA8Y=;
    b=LfO3RmLVCHeKqxyFq05BCUkJ+hEc08nOhAClgxTWDjRJj0w87El7mpFbFrL1j5Jmw0
    yXbDCD9J9xtU/Mle0kBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id K5d3611846PcLfl
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 4 Sep 2025 08:25:38 +0200 (CEST)
Message-ID: <a7c707b7-61e1-4c40-8708-f3331da96d34@hartkopp.net>
Date: Thu, 4 Sep 2025 08:25:32 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] docs: networking: can: change bcm_msg_head frames
 member to support flexible array
To: Alex Tran <alex.t.tran@gmail.com>
Cc: mkl@pengutronix.de, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250904031709.1426895-1-alex.t.tran@gmail.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20250904031709.1426895-1-alex.t.tran@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04.09.25 05:17, Alex Tran wrote:
> The documentation of the 'bcm_msg_head' struct does not match how
> it is defined in 'bcm.h'. Changed the frames member to a flexible array,
> matching the definition in the header file.
> 
> See commit 94dfc73e7cf4 ("treewide: uapi: Replace zero-length arrays with
> flexible-array members")
> 
> Bug 217783 <https://bugzilla.kernel.org/show_bug.cgi?id=217783>
> 
> Signed-off-by: Alex Tran <alex.t.tran@gmail.com>

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Thanks Alex!

> ---
>   Documentation/networking/can.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
> index bc1b585355f7..7650c4b5be5f 100644
> --- a/Documentation/networking/can.rst
> +++ b/Documentation/networking/can.rst
> @@ -742,7 +742,7 @@ The broadcast manager sends responses to user space in the same form:
>               struct timeval ival1, ival2;    /* count and subsequent interval */
>               canid_t can_id;                 /* unique can_id for task */
>               __u32 nframes;                  /* number of can_frames following */
> -            struct can_frame frames[0];
> +            struct can_frame frames[];
>       };
>   
>   The aligned payload 'frames' uses the same basic CAN frame structure defined



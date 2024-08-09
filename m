Return-Path: <linux-can+bounces-1184-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0D694CE12
	for <lists+linux-can@lfdr.de>; Fri,  9 Aug 2024 12:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 976F9B22D0A
	for <lists+linux-can@lfdr.de>; Fri,  9 Aug 2024 10:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B8B1940B9;
	Fri,  9 Aug 2024 09:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Bwwo+WCK";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="o2ofEY+j"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21681940B0;
	Fri,  9 Aug 2024 09:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723197480; cv=pass; b=bYtwsmxFC8TKaK9YJVdnnOS2yYRQaA9eIVKX8EbmuWmswQDScggIg6eua7PBE+azHXV16dBNbk8lMGvDkGiG17ElK/wIEFrSIaZw6zE+7BT1SiCwmOfJQushGR12XpaeWN1wol/JVe+hiwSfHq67psdjOc4lCZ7w0efDxgh5d28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723197480; c=relaxed/simple;
	bh=Xe+OAUVb0YFJIF+A8+YBN2gRFzDq6SrE2crXjLIltKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JhQifoAN9bN04gVssD1x/LXvZykqYHAlC7xaR6cuAwFCOCz0qlVG2IHgQc16ChZilE33c5QpQfYpVGkMILzmWBkhoxxs/jUkfpNP7PSyhpX+gH/6lw+XQqfI4IrzxtMAeQ/9szONs8xdIWZbtkLBGXseAFDTEH07epsVxVwcWk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Bwwo+WCK; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=o2ofEY+j; arc=pass smtp.client-ip=81.169.146.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1723197467; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=sOVWz2QymMSoe5vD+9p4VLE86h0YA7ZKRD7xdl/KHQOg24H1yhiviAOUZCl9a7oM57
    wS0XBu9GQvLK4ieC3mAiR84Moo3A9zDuvfTmMH9KVmzQbV33QXGQyNXL+pHB6mxQeEv7
    ykE5miIHJ6BjmapziewsXLmozU79/IVHC20/+4vsrcug1CIH1gm9HAieEUPLqFltAhBW
    MbU1YqRbzNH8pme2/brgJDKnrDhCYdsxzh0kf/P3cETW/NL6VHwWBU0LaUosABgRHdpG
    QyFCKKMCOGnPR/jfEsD7f9sso1QqJkzMHbE/dlbSqR5DULeutR069Nc+zS5RLkRbO0Lj
    7eww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1723197467;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=QEUSNXrqpbgI+XXA6QcuDSUYsyphVepWdKIB51JsmDA=;
    b=rRgtElqYS2qPu5JLzd/d2VCXw0/B3Vwv9/gJr8cir99KUCLQjkFvyDuSq+NWFGauaX
    Wk8PNlzIPvRfibwAaFoN+j5nwsUev290Nsl9nj+ujiqimTiCrg2lrJo+CBdj3BFP1a3k
    nm9NQndchoy00QoXM53IEIv08fMs3nSSelkBeIxfzu7Vnen2hUxRlov70PL1vKEpn75h
    GVOhbmq8+WG8fb0ACk6XIhrUANx9YM8xNsNxCrF2ExRdCFqeVMU75si+NBlP3tgj0Zou
    ueoHr/fNkMmaNVg9gD0a2y2fWO+cp43okjwx/Ov7HbAOQmcFSofcfnM9TYUvfVc3oqqB
    SZ8g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1723197467;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=QEUSNXrqpbgI+XXA6QcuDSUYsyphVepWdKIB51JsmDA=;
    b=Bwwo+WCKBtfPf5H9iZYVCGHEDKjr4si+atWvDMFpkSooFfVkeCObsppecM9tfaD9sJ
    HqriJNx52h2lm8C1rg4rtUqLGgNmDoaTQf3c3SmDsAiFn/kIYmDGvY+ZHlbLNJyvTnAZ
    LPiiaWm9jvhKDM8SSo1Gn1vtpcrra5JNCqfHrUW7GNA2yerDZMF0/s/+bkSwq/SRFaWH
    HnbbDkPk6MUxPViBvo4FnpE7ZlDH5EP/cL2wIEr8PMkBmBUCQyuX73NdpV8k7Eu81MnO
    lVxaZFTiv7Xa8//t0DC+ZcqmfNFjUYtycQ6w6HHXj1XxTwDqtDCylheg8XMnP55EnH24
    ZZjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1723197467;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=QEUSNXrqpbgI+XXA6QcuDSUYsyphVepWdKIB51JsmDA=;
    b=o2ofEY+jQ36873X/dwp/wbAF8Jh6QvKdSXHJWvYnmSoGJOW9JVHB5V80oxiDZYyUpE
    0+CKJAx7x+exo33WF0Cw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+4xtv9aJ67XA=="
Received: from [IPV6:2a00:6020:4a8e:5010::9f3]
    by smtp.strato.de (RZmta 51.1.0 AUTH)
    with ESMTPSA id K1860b0799vl3KA
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 9 Aug 2024 11:57:47 +0200 (CEST)
Message-ID: <2bf44b8d-b286-4a94-8e1d-6c4e736a1d07@hartkopp.net>
Date: Fri, 9 Aug 2024 11:57:41 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] Net: bcm.c: Remove Subtree Instead of Entry
To: David Hunter <david.hunter.linux@gmail.com>, mkl@pengutronix.de,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com
References: <20240808202658.5933-1-david.hunter.linux@gmail.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20240808202658.5933-1-david.hunter.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello David,

many thanks for the patch and the description.

Btw. the data structures of the elements inside that bcm proc dir should 
have been removed at that point, so that the can-bcm dir should be empty.

I'm not sure what happens to the open sockets that are (later) removed 
in bcm_release() when we use remove_proc_subtree() as suggested. 
Removing this warning probably does not heal the root cause of the issue.

What did you do to trigger the warning? Did you work with network 
namespaces or LXC/Docker and purged an entire namespace?

Best regards,
Oliver

On 08.08.24 22:26, David Hunter wrote:
> Fix a warning with bcm.c that is caused by removing an entry. If the
> entry had a process as a child, a warning is generated:
> 
> remove_proc_entry: removing non-empty directory 'net/can-bcm'...
> WARNING: CPU: 1 PID: 71 at fs/proc/generic.c:717 remove_proc_entry
> Call Trace:
> remove_proc_entry
> canbcm_pernet_exit
> ops_exit_list
> 
> Instead of simply removing the entry, remove the entire subdirectory.
> The child process will still be removed, but without a warning occurring.
> 
> This patch was compiled and the code traced with gdb to see that the
> tree  was removed. The code was run to see that the warning was removed.
> In addition, the code was tested with the kselftest
> net subsystem. No regressions were detected.
> 
> Signed-off-by: David Hunter <david.hunter.linux@gmail.com>
> ---
>   net/can/bcm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 27d5fcf0eac9..fea48fd793e5 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -1779,7 +1779,7 @@ static void canbcm_pernet_exit(struct net *net)
>   #if IS_ENABLED(CONFIG_PROC_FS)
>   	/* remove /proc/net/can-bcm directory */
>   	if (net->can.bcmproc_dir)
> -		remove_proc_entry("can-bcm", net->proc_net);
> +		remove_proc_subtree("can-bcm", net->proc_net);
>   #endif /* CONFIG_PROC_FS */
>   }
>   


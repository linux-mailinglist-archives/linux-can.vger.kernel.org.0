Return-Path: <linux-can+bounces-3542-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 115A2AABBDC
	for <lists+linux-can@lfdr.de>; Tue,  6 May 2025 09:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42EAC7AECAE
	for <lists+linux-can@lfdr.de>; Tue,  6 May 2025 07:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6509C2144A0;
	Tue,  6 May 2025 07:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="Q1NrcROw";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="F6XpS7iy"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDD320CCCC;
	Tue,  6 May 2025 07:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746514909; cv=pass; b=U4oy+yeS5dW3HgY++ofW7ENgUV37w9PnVqiUjE6SH+aFGCM2zFWVzLoQNU6sr7Ej/WsHjHRXl8ReRQP3ztsnpK4z4E/UJf/9u725BsuXmAoVruFDT3ifgrrb96zCnPXk7tMOQ8MM97Xakqof3frI2HQ5LYkglxOVp5118FgBz1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746514909; c=relaxed/simple;
	bh=XllqbI3xJZhAiQ/dxjHZbOg942lK7BhoDvXxGnARJaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eOSQx66YhRim/gjgPJQA7UlRjAOuF0umNTDOr7Ct26B21tWNkomiDMKx/snKCff8jNzGqZcztSZ4YyFDnCap0a40zzxvO/7oDuDRbZbHgQT3cSVw9fzgPiy8xihkzXCi9xZLk2irarIiNSW8H71qHPsRqQphtz7228VJHkqcL8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=Q1NrcROw; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=F6XpS7iy; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1746514183; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Hycpp/T+UZi/gwGWyEmRY6gRmxIojPuMFFe17ZwKRczYDeByJYkfSiRCJXlY+Q+wmU
    Qn4wf+Nrn8v1dkPKy2Lpj6jszMyfbQU55TWKojPIACOcy1y2WO6jg/3w4OoihdmiuLvI
    s8SFYfScge1EqK5/yvpevlPg8varD6ytkDDSqjhthXRM0RWv8l8JKFy2ANo63c5gdn1n
    AEfpGvtd4l0Fy9+GBerbAh1mG4tiN1rMV4jBebFSMtjpwFJJfE3loIGPLgaduLGzVEtY
    vG1cHC0+FKZ2fHIK8LdxOagEl+M1wlbiXUU3KjSlEac8JkphVOf0TUXVMGe6Lw0kIQZO
    OHPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1746514183;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=tfvTTDkinxycvawfTo7uNlXeAUnWjeraRoE1Ewjs8zA=;
    b=KIyQaTGyA0GB4Nq8xPwiq2Fp+mVrlNB1P9FHJjJ80E8FpvttCj9MqFf6KB4jeznum/
    jM9+aoRUADy5aBiq1039NUC1E0MPsr71XrQHTxDsqL39yEWFEYzrwUFcsRI8WdolznHe
    mpdL3WEHeHaR7FbaI6KwNa2YBnw/i+G4hCZvb8eV7z7QYzNU5XDjzysNTiQolc+QsTka
    FL40UoZGBErBI2QzRuuKo5moX0GYBdbRTqOg6CqVHXOizGnBrdMxqoqnolPGg9OIPqTX
    AilpKsXWZEDR2/upNDMArqJth6hMq/Q4Qw14RubGlk2zeZ8ZSt6Ryr9kQIMfluVCehjB
    37Yg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1746514183;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=tfvTTDkinxycvawfTo7uNlXeAUnWjeraRoE1Ewjs8zA=;
    b=Q1NrcROwAMHCnphs4inv02ZqDuO3WFSQfzwkoAboHDMCJv5JtblduSfa7AJjcq3cQE
    lFb53lSpAQ6Zb5iNbzR6bPqY9W1cgi87Xd/cgGoRDoWAjSK9zp8aggBR9S4Al/dxxu9q
    R6AorzODGMtqUU2Q3tF8w03XSJbQbQfCKQ4OJLneFVJh1ohcKhRIYCShpDeVRDlNXz93
    A2w8ne7ejJBC8U/O5qYOKFGc2GkJga4B6M8lSHS/SixCSTQixcTNa8iHeWKov5QCmYXa
    DPaTanupyHzxTMsNTVCJJUNW10n1UNYeDpW65f/gC2AZF1ZiPvzzGNbVyRme/tl6tcIy
    5KuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1746514183;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=tfvTTDkinxycvawfTo7uNlXeAUnWjeraRoE1Ewjs8zA=;
    b=F6XpS7iyfC1Ycs4ONSH0mhvf0HEFAs/L1upsREmm1qt6UO+eN3GhGLTB2rVHeyiekP
    Vmcy/HTYO7Rg+wdA8TDQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+5xtv9aJntXA=="
Received: from [IPV6:2a00:6020:4a8e:5000::9ae]
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id K2a3e51466ngmpo
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 6 May 2025 08:49:42 +0200 (CEST)
Message-ID: <640538cd-d1b6-46aa-9ef8-76aaa0e05609@hartkopp.net>
Date: Tue, 6 May 2025 08:49:37 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 6.14 624/642] can: fix missing decrement of
 j1939_proto.inuse_idx
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Davide Caratti <dcaratti@redhat.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Marc Kleine-Budde <mkl@pengutronix.de>, robin@protonic.nl,
 linux-can@vger.kernel.org
References: <20250505221419.2672473-1-sashal@kernel.org>
 <20250505221419.2672473-624-sashal@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20250505221419.2672473-624-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sasha,

this fix is needed for this commit

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/net/can?id=6bffe88452dbe284747442f10a7ac8249d6495d7

6bffe88452db ("can: add protocol counter for AF_CAN sockets")

which has been introduced in 6.15

It must not be applied to 6.14-stable.

Best regards,
Oliver


On 06.05.25 00:14, Sasha Levin wrote:
> From: Davide Caratti <dcaratti@redhat.com>
> 
> [ Upstream commit 8b1879491472c145c58c3cbbaf0e05ea93ee5ddf ]
> 
> Like other protocols on top of AF_CAN family, also j1939_proto.inuse_idx
> needs to be decremented on socket dismantle.
> 
> Fixes: 6bffe88452db ("can: add protocol counter for AF_CAN sockets")
> Reported-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Closes: https://lore.kernel.org/linux-can/7e35b13f-bbc4-491e-9081-fb939e1b8df0@hartkopp.net/
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Link: https://patch.msgid.link/09ce71f281b9e27d1e3d1104430bf3fceb8c7321.1742292636.git.dcaratti@redhat.com
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   net/can/j1939/socket.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
> index 17226b2341d03..6fefe7a687611 100644
> --- a/net/can/j1939/socket.c
> +++ b/net/can/j1939/socket.c
> @@ -655,6 +655,7 @@ static int j1939_sk_release(struct socket *sock)
>   	sock->sk = NULL;
>   
>   	release_sock(sk);
> +	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
>   	sock_put(sk);
>   
>   	return 0;



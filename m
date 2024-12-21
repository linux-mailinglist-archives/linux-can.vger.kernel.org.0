Return-Path: <linux-can+bounces-2480-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A18AD9FA146
	for <lists+linux-can@lfdr.de>; Sat, 21 Dec 2024 16:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF06D1887E98
	for <lists+linux-can@lfdr.de>; Sat, 21 Dec 2024 15:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5453E1F8661;
	Sat, 21 Dec 2024 15:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZvahHlPJ"
X-Original-To: linux-can@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8F42EB00;
	Sat, 21 Dec 2024 15:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734794284; cv=none; b=IiZvVx1uH80PBVPJ29qG9XGppTt3zDRy84K68XNBMshNsDg0ZxQRvWlbakOpgPaUuUE8dbnx3wyKbVIFeYt6fVYDNqNpNsj+ikW5DYADyDkzGSpNi+YfDa96jVd/PfP/gr98TSeT5cwhHx4rbSYARke0BAA8ZrYX1pXi6lLKTxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734794284; c=relaxed/simple;
	bh=5npocbCtF0vS/uYKknr1J0qqeN4M9EK8eV//ntVdydY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BM2i86D5HxDMgHQKb/YFE/vlmzzlO7grCNvNLQU8uW8PEZB8MlIQNr229vGbAK2jauGPoAUSf+zJHh0bRVqz8ZXjY0FMHv8hN4vqzgCsS1DQG5IVtrRik6ZYp4hH6KxnnI6oKNYRmfyV0NyxDfoPrjwC61l5iKDQ6nYR5VwWjRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZvahHlPJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Z/zWEEAFiJhjASlpovWheTu6czHSNtboPXzunoqWqNU=; b=ZvahHlPJqsL76Zxjdfy9FCDjBb
	R/IIqoL+hBFOYHVAXBMRe/18w94D3CLB21ThZMQNQEgVuk+qOmQmUlNs3meiujeTeeoDji8+TLh+F
	MnxwxMhl9c44kMQsd14CT/88imtLwLWkRnfBSAFHPhlIXQ58/oe1tKDGajSfglxyKYDA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tP1Er-002KPf-2D; Sat, 21 Dec 2024 16:17:57 +0100
Date: Sat, 21 Dec 2024 16:17:57 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
Cc: linux-media@vger.kernel.org, linux-mips@vger.kernel.org,
	netdev@vger.kernel.org, linux-can@vger.kernel.org,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 1/3] drivers/firmware/broadcom, ethernet/marvell: Remove
 unused values
Message-ID: <e99c8ff0-4b72-400b-a530-6808adbd5d1a@lunn.ch>
References: <20241221035352.1020228-1-ariel.otilibili-anieli@eurecom.fr>
 <20241221035352.1020228-2-ariel.otilibili-anieli@eurecom.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241221035352.1020228-2-ariel.otilibili-anieli@eurecom.fr>

On Sat, Dec 21, 2024 at 04:44:15AM +0100, Ariel Otilibili wrote:
> Coverity-IDs: 1487817, 1561102
> Signed-off-by: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>

One patch per driver please.

> --- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
> @@ -329,11 +329,9 @@ static int cn10k_mcs_write_rx_flowid(struct otx2_nic *pfvf,
>  	mac_da = ether_addr_to_u64(secy->netdev->dev_addr);
>  
>  	req->data[0] = FIELD_PREP(MCS_TCAM0_MAC_DA_MASK, mac_da);
> -	req->mask[0] = ~0ULL;
>  	req->mask[0] = ~MCS_TCAM0_MAC_DA_MASK;
>  
>  	req->data[1] = FIELD_PREP(MCS_TCAM1_ETYPE_MASK, ETH_P_MACSEC);
> -	req->mask[1] = ~0ULL;
>  	req->mask[1] &= ~MCS_TCAM1_ETYPE_MASK;
>  

As i said to another patch, you need to argue why you change is
correct. If you have no idea what the correct fix is, you should
simply report the issue to the Maintainer, and look at the git history
for these lines and see who added them, and ask them what is the
correct fix.

	Andrew


Return-Path: <linux-can+bounces-6047-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BEDD047F0
	for <lists+linux-can@lfdr.de>; Thu, 08 Jan 2026 17:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9645430AC062
	for <lists+linux-can@lfdr.de>; Thu,  8 Jan 2026 16:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23745262FC0;
	Thu,  8 Jan 2026 16:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="LcjS5J9R";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ZAe9Rv//"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F40826F467;
	Thu,  8 Jan 2026 16:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767889665; cv=pass; b=B02objL3oiYAT0awuS9eTY1rWBUYWJfB/iP2c+5geLpYJWlcoby9/DB6zVpnbvYFafzo58zGuashw+hW9GwQQZIdAHIP+s4bHVKdLEvJDKan+z7yFr7EPe2BkALb7rJvAx1DixlaD+DAodmgdotc14KRln9fP9emf1tt9GXtEtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767889665; c=relaxed/simple;
	bh=WgzbXX/qK8fzrQlh7m/oURdOZynAuquulT/LNEiIA3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zx+qW4ax/P8MYpDoQtu+c2x+8+EmMsc7eY+o4VpOmHJg7P0ZJ4EllF8qQwmtl/Uwm8ho1FqPPLVbNmZtG+Qi3T86VFAU13q3XQyBtLilE/oXCexOyI8PFLNmZzTsJGu5+p2Ztf0lTDTJGnvx80HDanJR1xVvJ279+7CumXAAwz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=LcjS5J9R; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ZAe9Rv//; arc=pass smtp.client-ip=81.169.146.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1767889653; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=HHEGGLnIt/OkKPaRLWHCE8BUqaKHEGlXRLuJFbHE5dBUNmpmd0B0VX3TyaYMsQ9cuK
    +M2ITjpOqnV0ZnfYiFq3S9rRp+efmBAvvLZeM0Ue5xvs9VpL9a92zgWirGQiHvmOA3qZ
    Opd7kdCRBF27YcoLyqn44CvoGn7C8+1ngNgMOTSSh9ZidiNzCENHvqKVVJYZ+Edl8TH3
    EScAPPR/6YghwH+4aKlLrAmLc9NqSjsIZtMpT5mzgfnr2DdsBoGWMjZ+f4rFpc+Ydomo
    eWdZ5Axx/tIu60nOnPMZXy3BZoUOBKjMpeMNEmYScDAWZyTTammjFmgtvQC1gyCBr+jn
    uvqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1767889653;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ynMYXxQV8/qp/U7DMUh5F+aC3Hp62DK36evAc9dOffY=;
    b=qovElqcRnhaKA/TARoyrC1erZedFT1pkLBPiFDizImpy86F+gL+/tr9p9WbTF27nOM
    K8t3xbTuHJz9RWu0TWBqPPD+WLKeGGSc9tqH2Df0Gwkf9AC8rd5JfySs9PF6gZwGrcRi
    HxtND41YEF0QdgUWC1pSJ5DkRLz4OBIyBEUuwIjFwKkkbY5NtodJAKXFYsQpOYmAP20w
    DZlC/K+NcUGOe3tAwkUwhIpI5FPrEWc0vsP/0yjWxhx0N8SLPDyvHAQ5+jXhZltwH8kh
    s5jzpjd3YEikYpeoanzZ1hJ/2fU9MigeG7d1b1QJvXySRQ7rfdM1MvNEloRT0eCJ/Jb8
    vGRg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1767889653;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ynMYXxQV8/qp/U7DMUh5F+aC3Hp62DK36evAc9dOffY=;
    b=LcjS5J9ROBFSLUCp0eNwso2ekLaqxsc6yT4P8S7S4cZ6LtXXmMpP6A04yrM7Mah9rw
    trse+qQq/ABaKh0IVKjq0kA9ZLlTrA3PUH3TJqwi2N/xvTLFRynkHWABwgx8+V32escY
    tLDd9IVNhh0PCduVvD7wZ1hd682MG27M/PJgeKgPYX2gAQIzS3sg7BLwEO7dnT1MohQ7
    TTvvoxTV9hOVXkAUAXxGfKg42ce7CJCNlMjvMMgykB9l4FXyOuFIjK96X0v9IyqzCDas
    +d/AI/ZOXkEK0L+IxTgsB9TArdBAb/b77glWgGuY9jKw+GoT0jW5+bEnTSpRxyZvRHPX
    JKBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1767889653;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=ynMYXxQV8/qp/U7DMUh5F+aC3Hp62DK36evAc9dOffY=;
    b=ZAe9Rv//UZ3Mnsmv06h/+h/HfUWu8JKjs0EQK0MafYEJk4UpxDU++obAq+ctOGJn/t
    bmvZH/XNT8hj2pR4r2DA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b208GRXJxE
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 8 Jan 2026 17:27:33 +0100 (CET)
Message-ID: <af5fd6da-f747-4f34-a866-f489c17dbe5a@hartkopp.net>
Date: Thu, 8 Jan 2026 17:27:27 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bpf, xdp] headroom - was: Re: Question about to KMSAN:
 uninit-value in can_receive
To: Jakub Kicinski <kuba@kernel.org>
Cc: mkl@pengutronix.de, Prithvi <activprithvi@gmail.com>, andrii@kernel.org,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, netdev@vger.kernel.org
References: <20251117173012.230731-1-activprithvi@gmail.com>
 <0c98b1c4-3975-4bf5-9049-9d7f10d22a6d@hartkopp.net>
 <c2cead0a-06ed-4da4-a4e4-8498908aae3e@hartkopp.net>
 <aSx++4VrGOm8zHDb@inspiron>
 <d6077d36-93ed-4a6d-9eed-42b1b22cdffb@hartkopp.net>
 <20251220173338.w7n3n4lkvxwaq6ae@inspiron>
 <01190c40-d348-4521-a2ab-3e9139cc832e@hartkopp.net>
 <20260102153611.63wipdy2meh3ovel@inspiron>
 <20260102120405.34613b68@kernel.org>
 <63c20aae-e014-44f9-a201-99e0e7abadcb@hartkopp.net>
 <20260104074222.29e660ac@kernel.org>
 <fac5da75-2fc0-464c-be90-34220313af64@hartkopp.net>
 <20260105152638.74cfea6c@kernel.org>
 <904fa297-b657-4f5b-9999-b8cfcc11bfa9@hartkopp.net>
 <20260106162306.0649424c@kernel.org>
 <8b55ae26-daba-4b2e-a10b-4be367fb42d0@hartkopp.net>
 <20260108071703.788c67ed@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260108071703.788c67ed@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.01.26 16:17, Jakub Kicinski wrote:
> On Wed, 7 Jan 2026 16:34:13 +0100 Oliver Hartkopp wrote:
>>> Alternatively perhaps for this particular use case you could use
>>> something like metadata_dst to mark the frame as forwarded / annotate
>>> with the originating ifindex?
>>
>> I looked into it and the way how skb_dst is shared in the union behind
>> cb[] does not look very promising for skbs that wander up and down in
>> the network layer.
> 
> Maybe I'm misunderstanding, but skb_dst is only unioned with some
> socket layer (TCP and sockmsg) fields, not with cb[]. It'd be
> problematic if CAN gw frames had to traverse routing but I don't
> think they do?

We are using skb's that are e.g. created on socket level and only 
contain fixed struct can[|fd|xl]_frames that are written into CAN 
controllers registers on netdev level. The skb is just a dumb container, 
which passes qdiscs and are stored in the CAN device cache until the CAN 
frame is sent successfully on the CAN bus. And when it was sent, the skb 
is echo'ed back via netif_rx() so that all local applications can see 
the real traffic on the CAN bus. So our skb's can go down and up.

I did some more investigation and created 5 RFC patches that solve the 
issue with the problematic private headroom (struct can_skb_priv) in CAN 
skbs.

I'll continue testing - but it looks pretty good so far.

Best regards,
Oliver


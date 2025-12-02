Return-Path: <linux-can+bounces-5807-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 022BCC9AE0B
	for <lists+linux-can@lfdr.de>; Tue, 02 Dec 2025 10:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E9B434E1194
	for <lists+linux-can@lfdr.de>; Tue,  2 Dec 2025 09:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7773081B8;
	Tue,  2 Dec 2025 09:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="dU9AW0xd";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ZBO1vwmz"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EE7309EE3
	for <linux-can@vger.kernel.org>; Tue,  2 Dec 2025 09:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764668033; cv=pass; b=iLt7y9d3O0VR+UeeWHyBsm4d0DnupAYgI4J/niK24gQFVQ1ttSqUNrgfPwVss9ZjA0H4f33o81iD/BYMk2RRulOP7TABo36jpGMyvxCm7F3v23v1y2t32jMOP77np6CPTxp/JFBtrDl9bMGA0fQKtvut5+uLW8Kst8s87R6kqTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764668033; c=relaxed/simple;
	bh=Lyt922GiqtUTjKZVLgSzCyS1rhTZf+9zJDlR1E+NK7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H07IonlldySTl1pDxyT8cgabMA7AIjuIARKr3aFvU3OoLaI2BCSBS4SdIu/swRMWqbYrzi7lqCKAPhdxoJpcf+fwC2QWvXcpm3eECZ9sUss/yMaTN0A5y0UOLpYFDjPy79Vq4AE61vFtkQHA50qMzihyAV8+6jaoJQj5EM+N2Bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=dU9AW0xd; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ZBO1vwmz; arc=pass smtp.client-ip=85.215.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1764668021; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Ub+8/HqgvCfp7ux+IqlNfxVH3AYEOOnYYg027uhlEKICPuBFhsALcqmtG/IyQyeE1S
    k37+vfU2w/e4Vgm+1tU1DbzkVmnzK6czAtgu15N4koqVgsdR3gXFS8GrvlqENrZdtExE
    4aC4rk1Sz4oWsnIVLlOb6CV8Q9HQEvmEMLskkq8EcqE27xOSFLSzNaY1Q/Jhm+rRqqK3
    gt1nhj7o3L3840iPYSL8Lv4zPE6DLnOij7giZ00mTUUt4a8UNmmbIfACFFvMmVeDJddL
    lsjmRRZmLz5ZFZCexAXIyB4m/4j6mmTdZS/wo8P/44sCyqXQ8C1EKZGooRml62LDH/aG
    kJhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1764668021;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=N/6nnOPIZlrS+YQ00SZfHcy0mGTNr17nLJp1Gv7g+Hk=;
    b=Mrei/7KKcJ1aWL/OSIl1vjkMCQybtNqkGInNAkQCoiENF76c8uRio1zFLbJAceUaN4
    Hjq8tkACfjemjm41YkCqQ3gEhifjhawcnq2tlNza+YLubapKWug8lj6zxFJpd6+LF9Fu
    plo1DojqcAVpHJGA0+9jJJA3N0rwKXav+5VSWucBA/xgzt1kUcJBsDxzcd87CP30AC+Z
    wkQ95rjGSQ30JGUDjXwdVl0Ksj1gWU5Z6DW2nK4LufWRXU2epfflQ0IRWASAgLFQPAls
    O1FhkjLTMek73zJAN8kNGRHfeURnPvPchbk4ROIwrc6Fs1Pvfh48sFqQcDMRxBnus6Ru
    8M2A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1764668021;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=N/6nnOPIZlrS+YQ00SZfHcy0mGTNr17nLJp1Gv7g+Hk=;
    b=dU9AW0xdN6jw4cm7xnt514wzuDXy3+MnHqGGq6H9M8gsMYZUBMynxK70SlozBU7qB+
    EpgrpTDcury0YWP7phhVMKA1TU74ZXm7WZI4G4t9niorSSo979UQbwv8KXr5tQVKEiY+
    GKYFD1Z7WNilR6C/oXzathJEHJuXlIwK5pvQ7S32CcA9KBT+UkuzchdRP4x0NZOt3NVH
    LV5gGd/+k5XFbh/qji3kOV83Uahzq7pml4VmX6mnGbdu4OpqsAnK3KfMQNEtF/lio6vW
    UUS3diBYgkthrlCxmB49yXLSi9x4iRTMyOpGU21DfqIAAzKIN227n6RuFvjqA9E+FlKs
    dz8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1764668021;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=N/6nnOPIZlrS+YQ00SZfHcy0mGTNr17nLJp1Gv7g+Hk=;
    b=ZBO1vwmzKFv0XrKutW6vt8iCh0lLHtBvPmPh8JTfvmBrAwiWRwWsjgSI+ZPHa7mWGt
    xFNdwjsPwOcI9qQe06BA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461B29Xe2oC
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 2 Dec 2025 10:33:40 +0100 (CET)
Message-ID: <e9f73ce3-254b-4145-8fb3-dda105182de1@hartkopp.net>
Date: Tue, 2 Dec 2025 10:33:40 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v2 0/7] iplink_can: add CAN XL support
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@free.fr>
References: <20251201-canxl-netlink-v2-0-dadfac811872@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20251201-canxl-netlink-v2-0-dadfac811872@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vincent,

as Stephen requested some changes anyway I would like to raise a remark 
about the patch naming.

On 01.12.25 23:55, Vincent Mailhol wrote:
> Support for CAN XL was added to the kernel in [1]. This series is the
> iproute2 counterpart.
> 
> Patches #1 to #3 are clean-ups. They refactor iplink_can's
> print_usage()'s function.
> 
> Patches #4 to #7 add the CAN XL interface to iplink_can.
> 
> [1] commit 113aa9101a91 ("Merge patch series "can: netlink: add CAN XL support")
> Link: https://git.kernel.org/netdev/net-next/c/113aa9101a91
> 
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> 
> ---
> Changes in v2:
> 
>    - add the "iproute2-next" prefix to the patches
> 
>    - s/matches/strcmp/g in can_parse_opt()
> 
>    - Patch #3: "s/mili second/milisecond/g" and "s/nano second/nanosecond/g"

"s/milisecond second/millisecond/g" ??

> 
>    - Patch #6: s/XL-TMS/TMS/g in print_ctrlmode()
> 
>    - Patch #7: Remove a double space in patch description
> 
> Link to v1: https://lore.kernel.org/r/20251129-canxl-netlink-v1-0-96f2c0c54011@kernel.org
> 
> ---
> Vincent Mailhol (7):
>        iplink_can: print_usage: fix the text indentation
>        iplink_can: print_usage: change unit for minimum time quanta to mtq
>        iplink_can: print_usage: describe the CAN bittiming units
>        iplink_can: add the "restricted" option

iplink_can: add RESTRICTED operation mode support

>        iplink_can: add initial CAN XL interface

iplink_can: add initial CAN XL support

>        iplink_can: add CAN XL's "tms" option

iplink_can: add CAN XL transceiver mode setting support

>        iplink_can: add CAN XL's PWM interface

iplink_can: add CAN XL TMS PWM configuration support

Best regards,
Oliver



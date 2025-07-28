Return-Path: <linux-can+bounces-4187-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FDEB141DF
	for <lists+linux-can@lfdr.de>; Mon, 28 Jul 2025 20:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE0313A89BB
	for <lists+linux-can@lfdr.de>; Mon, 28 Jul 2025 18:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8A226E175;
	Mon, 28 Jul 2025 18:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="SQBrfcrV";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="N+7ulSw0"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4132727E2;
	Mon, 28 Jul 2025 18:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753726833; cv=pass; b=bh+mnBuMsEiuTdQbpTg1VTQbwOGWxBaZEykkoTFvtpbZ+codVOg/Qoqf/l880BgQwg5Wg01OzWNBlZTKAE1eURH2W8pnD9xaUI0TLhvKE7GeIxykam1W4qHaOdy3KCFiCBVmWK4SyWNkCxzFLs9RK8mP1bXKiOp582h89wqD764=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753726833; c=relaxed/simple;
	bh=peVXsReusycOnb60wcU5g2Pmht2uVreS4gunlIyTQCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SO1haX+cUBbBz7JFxqIVoPq+pClboPgWNTcnZHCbmwcQEp3l3NM0QHEmavqYz9di3tgIZYSFPkn9xWEmk/kv9d99/IuuL1hAbcKSJPT9oIG7E+dI0fVkgUkYMvLs2+yBK32L1+RTcFm/mfIdxT1DJXhsrDzLFInn48Yk8y0He3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=SQBrfcrV; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=N+7ulSw0; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1753726468; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=lZpnOZQrZn1Pjw1yOKWSEntVg8Vt7DjFPvXcPVf9sd8x4BqoFZDqNrOFGJKoo4u5J8
    hzsDhZRLVyIGynzvdfA8/onktUI7+y+x8dHDU1jQbM0qqAnlOig+DQnKyxnUFLmtHpx8
    ZysFGbl0aYzXD42vgOgkSi6zLdfmInvCGLkzimW7Xx39kftw8BpR0j7HU4BO74gCrlEu
    4Wv7tjBnsnpVSfKAyIMRM9zyXBMqobURNSpuUHptB/fvnfrF2g6jd8lBiFBFWF9KCWqA
    JKBe/MeckwIwLdFnbRS3OlwPJ3YO/MaCgDcdC/fCEApKJz5uBhunvXSj/Sgw25Z76mpc
    HHHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1753726468;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Jo9ABBVKaruYbcZF77K2Rm0WfGuIMVjPhor2fl7eV2Y=;
    b=kMmmBccU09AS4uPZQcvOMFh2eTGsme5UIMmgC7U/CfDM8fI/seL2EH+6/qwnspy2jy
    p2n+vl4Zcn680ySP+8dK/3JuNqUxfEU/i84Vjn7RjULUJpSu1jnG4vqCIGEvJD9JXHXA
    5qTbc5uQMT0hAmLn1eVKrpMGdjH2O/o37ouE8O9TR9wnzYBJs4reBFb9PCNSdZSVtTAE
    EbCPM0wfnHcVZ1CZoqjZkbZ96nK4YDybirhLE4HBNdCAc5iH+Jh5G12dkL0ledqpM7/G
    GdcO1sDqLQ+FXQFfZYq8dRZCbqeUY2m/X72f8SGTx2fonK/DN+AXtVks/vc9pyq2X4xP
    1ttA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1753726468;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Jo9ABBVKaruYbcZF77K2Rm0WfGuIMVjPhor2fl7eV2Y=;
    b=SQBrfcrVnwSXHdKooYDaxUacXKX4RzrdWwMq8kzRNlGw9Bu2+GuSbgbVY+la2yAlOH
    6covTImoQFVChxO0IeNhIGE4EKWu5JHFJsFVWbqLIShIAgwpXyh2Svq4eVpr41gDsJto
    ZNMz/2vK0MgBDG6BQ9qGeyqJs5Ch7isYXHA8J4vzxRbio+5lHYYE3Qclr0LRtCv5nkh4
    sm2EuRj8aO3f/p8bCtr+CeSXlkCoKaU0WKq5frxblmX1QpXzoYmnRuq8zomhaUNjvRZx
    q+5Ijsxp51e59PUgoedGJEAWXsokXNQ12oqCT8VKsaEAyCu8RxVij10Sp0iXPRCQqCnv
    8Ewg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1753726468;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Jo9ABBVKaruYbcZF77K2Rm0WfGuIMVjPhor2fl7eV2Y=;
    b=N+7ulSw09WyYo8oNE/QAfBhmyloYq4qokHDgLXiK3T6zcQDl1W01JSKWbsJzaiqijD
    yd/2ZIUbv30YCHeg+iBg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+4xtv9aJntXA=="
Received: from [IPV6:2a00:6020:4a8e:5010::9ae]
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id K5d36116SIERlk9
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 28 Jul 2025 20:14:27 +0200 (CEST)
Message-ID: <64bf8703-c80c-4a96-a5ad-0efc48bf0541@hartkopp.net>
Date: Mon, 28 Jul 2025 20:14:22 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: canxl: add CANXL_PMS flag
To: Vincent Mailhol <mailhol@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Robert Nawrath <mbro1689@gmail.com>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250729-can_tms-v1-1-21d0195d1dd0@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20250729-can_tms-v1-1-21d0195d1dd0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Vincent,

On 28.07.25 18:23, Vincent Mailhol wrote:
> The Transceiver Mode Switching (TMS) indicates whether the CAN XL
> controller shall use the PWM or NRZ encoding during the data phase.
> 
> Contrarily to CAN FD's BRS flag, CAN XL does not have an explicit bit
> on the bus to indicate the TMS. Instead, this is done implicitly: the
> transceiver will automatically detect TMS on the fly if the frequency
> on the ADH bit is higher than the nominal frequency and this until the
> DAH bit on which the frequency returns to back normal. For this
> reason, the TMS is something which, same as the BRS, should be
> configurable at the frame level and not at the netlink level.
> 
> The term "transceiver mode switching" is used in both ISO 11898-1 and
> CiA 612-2 (although only the latter one uses the abbreviation TMS). We
> adopt the same naming convention here for consistency.
> 
> Add the CANXL_TMS flag to the canxl_frame->flags list.
> 
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> ---
> The CAN XL did not make it on time for the 6.17 merge windows, sorry
> for that.

Yes. I'm a bit sad about that.

> Regardless, I finally went through the CiA 612-2 document. I
> have the PWM verification and automatic calculation working fine
> locally.
> 
> But before that, I want to sort out this TMS thing. That is why I am
> sending this unique patch. Once this discussion reaches an end, I will
> fine tune my work-in-progress accordingly.
> 
> Looking at the past exchanges, this TMS was the missing piece. I was
> already troubled by this when reading ISO 11898-1. That document makes
> it clear that the TMS can be deactivated but does not clearly point
> out at which level (netlink or frame). The CiA 612-2 clarified this.
> 
> So this CANXL_TMS flag partially replaces the CAN_CTRLMODE_XL_TRX. I
> say partially because I still do not fully understand if there should
> be an option to fully deactivate the TMS at the netlink level.
> 
> My gut felling is that the TMS is intended to work in a similar
> fashion as the CAN FD's BRS. In CAN FD, we do not have a
> CAN_CTRLMODE_FD_BRS to tell that FD should operate only using the
> nominal bittiming. And so, I do not get why CAN XL should be different
> and have a CAN_CTRLMODE_XL_TMS (or CAN_CTRLMODE_XL_TRX).
> 
> Stéphane and Oliver: maybe the datasheet of your CAN XL board have
> some additional insights? Did you see a register allowing to globally
> deactivate the TMS (i.e. not only at the frame level)?

You can take a look at the XCAN manual 
https://github.com/linux-can/can-doc/blob/master/x_can/xcan_user_manual_v350.pdf

And I have a XCANB specification which is a simple (non-DMA) CAN XL 
controller.

The TMS switching is only possible in netlink level and there's no 
TMS-style bit in the CAN XL frame layout that is pushed into the 
controller to send a CAN XL frame => there is not TMS-bit analogue to 
the BRS-bit your were searching for.

Therefore this patch is obsolete.

Btw. while we are at it: I would suggest for a name change of

CAN_CTRLMODE_XL_TRX

to

CAN_CTRLMODE_XL_TMS

as it makes clear how the controller should manage the PWM mode.

"CAN_CTRLMODE_XL_TRX" would mean "there is a CAN XL PWM enabled 
transceiver" available which tells nothing about whether the PWM mode is 
used or not.

Best regards,
Oliver

> 
> Finally, on a side not, now that I have my kernel.org account, I am
> changing my e-mail address from mailhol.vincent@wanadoo.fr to
> mailhol@kernel.org. 

Nice!

> The wanadoo.fr address was my first email which I
> created when I was a kid and have a special meaning to me, but it is
> restricted to maximum 50 messages per hour which starts to be
> problematic on threads with many people CC-ed.
> ---
>   include/uapi/linux/can.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
> index 42abf0679fb4854cfa4f29a575e49527461a20f3..4a81500c1a06a69707accbf66224da7285d9d282 100644
> --- a/include/uapi/linux/can.h
> +++ b/include/uapi/linux/can.h
> @@ -193,6 +193,7 @@ struct canfd_frame {
>   #define CANXL_XLF 0x80 /* mandatory CAN XL frame flag (must always be set!) */
>   #define CANXL_SEC 0x01 /* Simple Extended Content (security/segmentation) */
>   #define CANXL_RRS 0x02 /* Remote Request Substitution */
> +#define CANXL_TMS 0x04 /* Transceiver Mode Switching (fast mode using PWM encoding) */
>   
>   /* the 8-bit VCID is optionally placed in the canxl_frame.prio element */
>   #define CANXL_VCID_OFFSET 16 /* bit offset of VCID in prio element */
> 
> ---
> base-commit: fa582ca7e187a15e772e6a72fe035f649b387a60
> change-id: 20250727-can_tms-4bd8510bc9ce
> 
> Best regards,



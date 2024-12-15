Return-Path: <linux-can+bounces-2409-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE4E9F2293
	for <lists+linux-can@lfdr.de>; Sun, 15 Dec 2024 09:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F89318867FE
	for <lists+linux-can@lfdr.de>; Sun, 15 Dec 2024 08:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BAF1758B;
	Sun, 15 Dec 2024 08:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="MR1CGRh9"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-18.smtpout.orange.fr [193.252.22.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0643A440C
	for <linux-can@vger.kernel.org>; Sun, 15 Dec 2024 08:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734250498; cv=none; b=Bpx9QHCWCDn2XbFDelJRpbYpeWKbMbTZsfczzy/k03KHByCPlukzP4eGhzwoRXQXeaWsPWHZA691UEfKmaa+QnTZNv7L2KQlLD/zV2uXlYi6gE/U5BWjC/CTI+dWKBozgCOsdTxcBpwsUvF6XUoSpmHvbd8sSSuVcmfBM1bnp9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734250498; c=relaxed/simple;
	bh=oVtOGbYMObXCecU6PDBzMBaPI5+a6+7c2GdkGsC/nSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q/aim1CauhdgNyGXA+6nk/859Y98gZ7Nw8qGjHplpH6BN442W4Y8OfhtHU8rwl6BQDWFF5+0JCiWgefrmQUpHT6CSgZrZea/FQTVr/R1do9v8ENgHHstx6uCIr0/lNKCeU6By1nF8E096rvzGHvXU+baUJohimvzt99NrDNlWBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=MR1CGRh9; arc=none smtp.client-ip=193.252.22.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id MjdLt65r5aH0QMjdWtzGCt; Sun, 15 Dec 2024 09:06:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1734249961;
	bh=o3yI10mQZnIeBWEkKVrGK1gkj3IupwOxla/+5QZeets=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=MR1CGRh9fQ5Y0rMe2UV7St6IQejJNMWRB0I/vkxWsxtgWuwFD60H2sIbU/UHfcJ7A
	 etWMvsljBxN5CPoKCXJNf5unPSGN4fr0ceQrGHaJx8ZXFKuwMmPwyR0zwAHywFcMO/
	 Fk2K8+9f3zQcBft7iUnu1AJTEj/g/OEAHMSjbirX3KwTmEAlhj8jC+Yq7k3GYG23J1
	 ZStbLnrTRmdwGa4dW047+KzekvJXRrkhymYRJ83yt6gzRiUw1jrSJm/XQ2bwma3DfA
	 bOGelfiMZ97cSh56pca7IIW/dme1v/IwYrtQHgPuj2RSccgL6LLfHnrlZbQTO8vwsK
	 SI79oX2YdbbNw==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Sun, 15 Dec 2024 09:06:01 +0100
X-ME-IP: 124.33.176.97
Message-ID: <70fd9522-7548-4a53-97db-dfb7619cb3b7@wanadoo.fr>
Date: Sun, 15 Dec 2024 17:05:46 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 12/14] can: netlink: add CAN XL support
To: Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Robert Nawrath <mbro1689@gmail.com>
References: <20241110155902.72807-28-mailhol.vincent@wanadoo.fr>
 <20241112-flashy-straight-poodle-9a796d-mkl@pengutronix.de>
 <CAMZ6RqKQLaEtgoLOAa3NHJotyHcAo=7ObXf=7tLh_DJ_QTCKOg@mail.gmail.com>
 <36b1f1cb-c431-43ad-be49-5093a3534b9d@hartkopp.net>
 <20241204-nippy-vivid-mantis-ee1725-mkl@pengutronix.de>
 <8d1cd5de-ae84-455d-8636-7f269bbfe7db@hartkopp.net>
 <20241204-mauve-asp-of-fortitude-e75174-mkl@pengutronix.de>
 <aeb667e7-9a5b-4d6f-8220-ac06dbdcfe80@hartkopp.net>
 <20241205-archetypal-stirring-kakapo-407537-mkl@pengutronix.de>
 <572d0fa8-e9df-4047-951f-2747571086db@hartkopp.net>
 <20241210-alluring-cunning-swift-4bcd47-mkl@pengutronix.de>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
In-Reply-To: <20241210-alluring-cunning-swift-4bcd47-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/12/2024 at 20:58, Marc Kleine-Budde wrote:
> On 09.12.2024 14:13:29, Oliver Hartkopp wrote:
>>
>>
>> On 05.12.24 10:15, Marc Kleine-Budde wrote:
>>> On 05.12.2024 09:16:44, Oliver Hartkopp wrote:
>>>> On 04.12.24 12:44, Marc Kleine-Budde wrote:
>>>>> On 04.12.2024 12:35:43, Oliver Hartkopp wrote:
>>>>>>>>> Also, the main reason for not creating the nest was that I thought
>>>>>>>>> that the current bittiming API was stable. I was not aware of the
>>>>>>>>> current flaw on how to divide tseg1_min. Maybe we should first discuss
>>>>>>>>> how to solve this issue for CAN FD?
>>>>>>>>
>>>>>>>> I like the current way how you added the CAN XL support.
>>>>>>>> It maintains the known usage pattern - and the way how CAN XL bit timings
>>>>>>>> are defined is identical to CAN FD (including TDC).
>>>>>>>>
>>>>>>>> Is the separation of propseg and tseg1 that relevant?
>>>>>>>> Does it really need to be exposed to the user?
>>>>>>>
>>>>>>> There are IIRC at least 2 CAN-FD cores where the prop segment and phase
>>>>>>> segment 1 for the data bit timing have not the same width. This means we
>>>>>>> have to change the bittiming_const in the kernel.
>>>>
>>>> Sure?
>>>
>>> I'm sure the registers don't have the same width. And I'm sure about my
>>> conclusion, but that's up for discussion :)
>>>
>>> https://elixir.bootlin.com/linux/v6.12.1/source/drivers/net/can/ctucanfd/ctucanfd_base.c#L197
>>> https://elixir.bootlin.com/linux/v6.12.1/source/drivers/net/can/flexcan/flexcan-core.c#L1210
>>>
>>>> In the end (almost) every CAN controller has the tseg1 register which
>>>> contains prop_seg + phase_seg1 as a sum of these.
>>>
>>> Some do (just a short grep): bxcan, esdacc, rcar_can, softing, hi311x,
>>> ti_hecc. More controllers haven evenly divided prop_seg + phase_seg1.
>>>
>>>> The relevant point is behind prop_seg + phase_seg1 and I'm pretty sure these
>>>> "2 CAN-FD cores" will add the values internally too.
>>>
>>> As the ctucanfd is open you can have a look :)
> 
> As far as I understand, it internally adds sync + prop + phase1:
> 
> https://gitlab.fel.cvut.cz/canbus/ctucanfd_ip_core/-/blob/master/src/prescaler/bit_time_cfg_capture.vhd?ref_type=heads#L242
> 
>>>> I'm a bit concerned that after 40 years someone shows up with the idea to
>>>> spend two registers for the tseg1 value instead of one.
>>>
>>> It doesn't matter if prop_seg and phase_seg1 are in the same register or
>>> not, what matters is:
>>> a) 1. does the IP core want separate prop_seg and phase_seg1 values
>>>     - or -
>>>     2. does the IP core want a single "prop_seg + phase_seg1", a.k.a.
>>>        tseg1 value?
>>> b) 1. what's the width of the prop_seg and phase_seg1?
>>>     2. what's the width of tseg1?
>>>
>>> Currently the CAN infrastructure allows the driver to specify tseg1 only
>>> and assumes the width of prop_seg and phase_seg1 to be the same, as it
>>> distributes tseg1 evenly between prop_seg and phase_seg1:
>>>
>>> https://elixir.bootlin.com/linux/v6.12.1/source/drivers/net/can/dev/calc_bittiming.c#L155
>>>
>>> This leads to the workarounds in the CAN drivers, see above for links.
>>
>> Yes. But why don't we just let this as-is then?
>>
>> Even if prop_seg phase_seg1 registers have a different size, this split up
>> can be done easily without changing the current bittiming API.
>>
>> Maybe a common helper function to split up the values based on given
>> register sizes could simplify the handling for those CAN drivers.
> 
> Good idea!
> 
> What about adding the information about prop_seg and phase_seg1 to
> bittiming_const and let the can_calc_bittiming() calculate it?
> 
>> I'm still not convinced that it brings some benefits for the user to extend
>> the bittiming API. IMHO it just complicates the bitrate settings.
> 
> The benefit is, that the user knows about the limitation of prop_seg and
> phase_seg1.

I finally caught up with this thread. As I said before I was divided on
this topic two weeks ago, and still I am today.

One part of me tells me that if the ISO mandates the prop_seg and the
phase_seg1 as two different configurable variables, then so shall it be.

The other part of me tells me that the benefit is small. The transceiver
does not need to know the tseg1 split to figure out the sample point. So
this is only useful for the user.

One thing I am sure of: I am against deprecating the struct
can_bittiming_const and creating a new nested structure with all the
configuration ranges. I do not want to have two branches of code: one
for the legacy struct can_bittiming_const, one for the new nest. It will
needlessly complicate the logic.

If we want to add the prop_seg to the configuration, the best is to just
reuse what we have and only add an extension for what is missing:

  /*
   * IFLA_CAN_BITTIMING_CONST_EXT nest: additional bit-timing constants
   * Extension of the struct can_bittiming_const.
   */
  enum {
  	IFLA_CAN_BITTIMING_CONST_PROP_SEG_MAX,	/* u32 */

  	/* add new constants above here */
  	__IFLA_CAN_BITTIMING_CONST,
  	IFLA_CAN_BITTIMING_CONST_MAX = __IFLA_CAN_BITTIMING_CONST - 1
  };


I purposely omitted IFLA_CAN_BITTIMING_CONST_PROP_SEG_MIN, because the
standard already specifies that this minimum value is one.

The CAN netlink interface then gets three additional entries:

  IFLA_CAN_CC_BITRATE_CONST_EXT,
  IFLA_CAN_FD_BITRATE_CONST_EXT,
  IFLA_CAN_XL_BITRATE_CONST_EXT,

all pointing the the new IFLA_CAN_BITTIMING_CONST_EXT nest.

Finally, we create a new *internal* structure (i.e. not visible from
uapi) that will replace the previous one in can_priv.

  /*
   * CAN internal bit-timing constant
   *
   * Used for calculating and checking bit-timing parameters,
   * extended from struct can_bittiming_const.
   */
  struct can_bittiming_const_ext {
  	char name[16];	/* Name of the CAN controller hardware */
  	u32 tseg1_min;	/* Time segment 1 = prop_seg + phase_seg1 */
  	u32 tseg1_max;
  	u32 tseg2_min;	/* Time segment 2 = phase_seg2 */
  	u32 tseg2_max;
  	u32 sjw_max;		/* Synchronisation jump width */
  	u32 brp_min;		/* Bit-rate prescaler */
  	u32 brp_max;
  	u32 brp_inc;
  	u32 prop_seg_max;	/* 0: not set, legacy behaviour */
  };

The first fields up to the brp_inc matches the struct
can_bittiming_const, the last field, prop_seg_max, matches the
IFLA_CAN_BITTIMING_CONST_EXT nest. If prop_seg_max is zero, we keep the
old behaviour: 50/50 split.

This gives the same results for less work and all of the Classical CAN,
CAN FD and CAN XL will use the same logic. And biggest point: no need to
deprecate any existing code.

Note that with this approach, it does not matter if we do it before or
after the introduction on CAN XL.

@Marc, I am fine to do the netlink part if you are willing to the
bittiming and the driver part. Deal?


Yours sincerely,
Vincent Mailhol


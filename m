Return-Path: <linux-can+bounces-3761-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1CBACB3B2
	for <lists+linux-can@lfdr.de>; Mon,  2 Jun 2025 16:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1BF31BA4BE5
	for <lists+linux-can@lfdr.de>; Mon,  2 Jun 2025 14:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD099221734;
	Mon,  2 Jun 2025 14:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="o9Xilq8Q"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-70.smtpout.orange.fr [193.252.22.70])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1441DED64;
	Mon,  2 Jun 2025 14:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748874691; cv=none; b=BvEyW6ll2TPYbxmRl0HHJB3LE8EX6bVz4cargnXoohl/+fm42fYYG+uJPoB1cyeVf9fMtieqJePpABFidqr2UFJTQwsuZm05qSwPxC8GxfgPiC4iYuM/BCegZHJNULZQwoZVzt1AR2yImDkpMci0eTzJ+CuH7Tv5XW8JvRfqSTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748874691; c=relaxed/simple;
	bh=dSVlQCm404ApOOuS0eCiGxGQ1DYx37Tx/wvDQZR7JWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bf5FlEAGSm/oT/WulLyOnsIvoJgt2PspkGkafmXuSmikd9HNXLkzRQPTG6qy8SQZkoysmKnLLZPlv7b/M6XaiJRDBHZT67azhCAhAmD4G28Hl/4rHZDh98tZ8wzKiE8Lc8VGd26rn3izoru6MqynO85jU6XSpJz9FSv+0laVyTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=o9Xilq8Q; arc=none smtp.client-ip=193.252.22.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id M6C3upBvadABIM6C4u921e; Mon, 02 Jun 2025 16:31:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1748874680;
	bh=G+TBX5u9TUi05fYiN+r99LSYOgeBMN5WCN8pgoA5t3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=o9Xilq8QNI6YRR5MJzD+7kob8PZA7liwlOGVrPZBPZLR1oyg26pINPuBkkGBycdJ+
	 1Y2uZmZN46OW8OB6ZPMfIzRXOzSZILm9DNBgFzzBWmOZv5+H2x8rnMyKGkdZyUG9oC
	 8kb2wTiAUjKAo1g1tkzuy+4Cl1THhi6ViwZVu0o8NUap5CSwvp7/krvQB/FK5gXAv8
	 EyWC5jJDNTp6JmFIgKvvbx6DCTm02echhA5VaiuyzHo/RinriOxANMUWgYnefZqTrR
	 /Y3+3YGIFqknUQfBjKOE+yjj0bM/cPb3yB8FSTuYcqRXSW7/6oDftbrxNwfia9s3CA
	 tYuILxxbd/MaA==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Mon, 02 Jun 2025 16:31:20 +0200
X-ME-IP: 124.33.176.97
Message-ID: <35fe01ef-6ad0-4d07-8138-85a2c87f6c90@wanadoo.fr>
Date: Mon, 2 Jun 2025 23:31:14 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] can: rcar_canfd: Repurpose f_dcfg base for other
 registers
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Kazuhiro Takagi <kazuhiro.takagi.hh@hitachi-solutions.com>,
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <cover.1748863848.git.geert+renesas@glider.be>
 <f9c114fcf8cc8eaae150a3ce95dd3224cf247f6b.1748863848.git.geert+renesas@glider.be>
 <94755286-47fb-461e-9850-e14830f2536e@wanadoo.fr>
 <CAMuHMdXaqDNE6dcSdDO+TersETtu8wrAhH_0DA1v3ngpPkneZA@mail.gmail.com>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Autocrypt: addr=mailhol.vincent@wanadoo.fr; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 LFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+wrIEExYKAFoC
 GwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTtj3AFdOZ/IOV06OKrX+uI
 bbuZwgUCZx41XhgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQq1/riG27mcIYiwEAkgKK
 BJ+ANKwhTAAvL1XeApQ+2NNNEwFWzipVAGvTRigA+wUeyB3UQwZrwb7jsQuBXxhk3lL45HF5
 8+y4bQCUCqYGzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrbYZzu0JG5w8gxE6EtQe6LmxKMqP6E
 yR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmceMvMCGwwF
 CQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8VzsZwr/S44HCzcz5+jkxnVVQ5LZ4B
 ANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <CAMuHMdXaqDNE6dcSdDO+TersETtu8wrAhH_0DA1v3ngpPkneZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/06/2025 at 22:49, Geert Uytterhoeven wrote:
> Hi Vincent,
> 
> On Mon, 2 Jun 2025 at 15:16, Vincent Mailhol <mailhol.vincent@wanadoo.fr> wrote:
>> On 02/06/2025 at 20:54, Geert Uytterhoeven wrote:
>>> Reuse the existing Channel Data Bitrate Configuration Register offset
>>> member in the register configuration as the base offset for all related
>>> channel-specific registers.
>>> Rename the member and update the (incorrect) comment to reflect this.
>>>
>>> This fixes the addresses of all other (currently unused)
>>> channel-specific registers on R-Car Gen4 and RZ/G3E, and allows us to
>>> replace RCANFD_GEN4_FDCFG() by the more generic RCANFD_F_CFDCFG().
>>>
>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>> ---
>>>  drivers/net/can/rcar/rcar_canfd.c | 22 ++++++++++------------
>>>  1 file changed, 10 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
>>> index 0cad3c198e58e494..7a9a88fa5fb1a521 100644
>>> --- a/drivers/net/can/rcar/rcar_canfd.c
>>> +++ b/drivers/net/can/rcar/rcar_canfd.c
>>> @@ -425,18 +425,16 @@
>>>  #define RCANFD_C_RPGACC(r)           (0x1900 + (0x04 * (r)))
>>>
>>>  /* R-Car Gen4 Classical and CAN FD mode specific register map */
>>> -#define RCANFD_GEN4_FDCFG(m)         (0x1404 + (0x20 * (m)))
>>> -
>>>  #define RCANFD_GEN4_GAFL_OFFSET              (0x1800)
>>>
>>>  /* CAN FD mode specific register map */
>>>
>>>  /* RSCFDnCFDCmXXX -> RCANFD_F_XXX(m) */
>>> -#define RCANFD_F_DCFG(gpriv, m)              ((gpriv)->info->regs->f_dcfg + (0x20 * (m)))
>>> -#define RCANFD_F_CFDCFG(m)           (0x0504 + (0x20 * (m)))
>>> -#define RCANFD_F_CFDCTR(m)           (0x0508 + (0x20 * (m)))
>>> -#define RCANFD_F_CFDSTS(m)           (0x050c + (0x20 * (m)))
>>> -#define RCANFD_F_CFDCRC(m)           (0x0510 + (0x20 * (m)))
>>> +#define RCANFD_F_DCFG(gpriv, m)              ((gpriv)->info->regs->coffset + 0x00 + (0x20 * (m)))
>>> +#define RCANFD_F_CFDCFG(gpriv, m)    ((gpriv)->info->regs->coffset + 0x04 + (0x20 * (m)))
>>> +#define RCANFD_F_CFDCTR(gpriv, m)    ((gpriv)->info->regs->coffset + 0x08 + (0x20 * (m)))
>>> +#define RCANFD_F_CFDSTS(gpriv, m)    ((gpriv)->info->regs->coffset + 0x0c + (0x20 * (m)))
>>> +#define RCANFD_F_CFDCRC(gpriv, m)    ((gpriv)->info->regs->coffset + 0x10 + (0x20 * (m)))
>>
>> I really start to dislike all those function like macros in the rcar_canfd
>> driver. The only benefits of a function like macro is either to have type
>> polymorphism or to generate integer constant expression or to work with context
>> specific info (e.g. __func__ or __LINE__).
> 
> I agree much can be improved in the way this driver accesses registers.
> Unfortunately a large part of it is due to the horrendous naming of the
> registers in the documentation, and the two different register layouts.
> 
>> Can you just change these five function like macros to static functions?
> 
> I assume you want something like was done commit 6b9f8b53a1f3ad8e
> ("can: rcar_canfd: Add rcar_canfd_setrnc()")?
> 
> These five macro just calculate the offsets for specific registers
> and for the specified channel indices.  Their return values are to
> be passed to one of the five accessors that take register offsets
> (rcar_canfd_{read,write,set_bit,cleat_bit, update}()).  Hence
> converting the macros to accessor functions means there will be more
> than five functions...

Not necessarily, you can just have:

  rcar_canfd_f_dcfg()
  rcar_canfd_f_cfdcfg()
  ...

and so on. Those would be used exactly the same way as the current function like
macro.

Or you can have:

  #define RCANFD_F_DCFG_BASE 0x00
  #define RCANFD_F_CFDCFS_BASE 0x04
  ...

and then a:

  rcar_canfd_get_c_reg(coffset, base, m)


I am keen on letting you decide what you think is best.

>> And from now on, each time there is a need to modify one of the rcar_canfd, I
>> would like this to become an opportunity to little by little clean up that macro
>> madness.
> 
> That's exactly what Biju and I are doing, slowly ;-)


Yours sincerely,
Vincent Mailhol



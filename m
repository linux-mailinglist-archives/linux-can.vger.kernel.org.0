Return-Path: <linux-can+bounces-2842-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E02A39F73
	for <lists+linux-can@lfdr.de>; Tue, 18 Feb 2025 15:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A81E216BB15
	for <lists+linux-can@lfdr.de>; Tue, 18 Feb 2025 14:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F320F26A0FD;
	Tue, 18 Feb 2025 14:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Lu2BCr7f"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-70.smtpout.orange.fr [193.252.22.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0115C26A0CF;
	Tue, 18 Feb 2025 14:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739888774; cv=none; b=ARZMiHXy1fcGNbx3RrmzQmpWAocpurn6730ukN1Fv/+jlwj+h32TfulNHot46FBe0bd/U6CswkM7ifyPV5qP4n22IhnVZIXlfBs83WgAxq1aQX9QNf6+0z0ZACxPZgCfEx4WiwRblXBcUwpnOPHKAmjHqSbVLNHq0z3/2Kkkz9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739888774; c=relaxed/simple;
	bh=Mp8d6EpMBRloZvPuJiF6u2bGZ//0HJO6xupro/jSprM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kPT5r8E89tXaEN2C36tdtLAmwOxdHn85vtlMqqrY7gdk4sCBaH4i4vbqvSazYefbyhuifVDbgWQYxIOdXxMlkQJNrBFDuiYaKPPvPhovzxUlahv7G3Kdd9lvQxi6elAYnQIRVNxm2u0XHrcHjM/V5rC7NWB8nVxo0jdSQFQWWWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Lu2BCr7f; arc=none smtp.client-ip=193.252.22.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id kOXytQovqwhW2kOY3t9Tl3; Tue, 18 Feb 2025 15:26:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1739888769;
	bh=FOM6aVLTCFQEhcAakTKCUK4aqN5niM+ARVw4hM5AxUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Lu2BCr7fJIuZOr77zdaf58BTviH5sweS4ZpReMKNTRPkmXsHzzmeR9rLc4eWkC1zG
	 /PnLPl9yBgUbCSiNLnb8cmA074iI0qSIcJxw4PJugCFQtI8AYF1S2RZx81A/w9Hn8M
	 L7mpQ/ixYp7nZ9kTxppR3t1G11kCevgapOv2lwb9nLn2iQs/pla93H+tEuN/hrx+A0
	 qpV8I7fi1oDnCCEdHbNdhbd/f1C2pz3knB+MJs+pGqt2aBqa5bhyYhHzSE5uii6lW3
	 V/XlR7HnJbpkNs+yQ73pl10f6lEhIuhCWtAGzxajx2RKbK4FweapZRbR54ebM8TsEw
	 EF2zOZHKtEwnw==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 18 Feb 2025 15:26:09 +0100
X-ME-IP: 124.33.176.97
Message-ID: <b174cc40-d08b-42a5-89fc-9fdac2b15ea9@wanadoo.fr>
Date: Tue, 18 Feb 2025 23:26:01 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: ucan: Correct the size parameter
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Matt Jan <zoo868e@gmail.com>,
 syzbot+d7d8c418e8317899e88c@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, linux-can@vger.kernel.org
References: <67b323a4.050a0220.173698.002b.GAE@google.com>
 <20250217190404.354574-1-zoo868e@gmail.com>
 <2f33170a-f7bb-47dd-8cb7-15c055dabc83@wanadoo.fr>
 <20250218-accurate-viridian-manatee-6f2878-mkl@pengutronix.de>
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
In-Reply-To: <20250218-accurate-viridian-manatee-6f2878-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/02/2025 at 16:37, Marc Kleine-Budde wrote:
> On 18.02.2025 11:22:11, Vincent Mailhol wrote:
>> On 18/02/2025 at 04:04, Matt Jan wrote:
>>> According to the comment, the size parameter is only required when
>>> @dst is not an array, or when the copy needs to be smaller than
>>> sizeof(@dst). Since the source is a `union ucan_ctl_payload`, the
>>> correct size should be sizeof(union ucan_ctl_payload).
>>
>> While this fix is correct, I think that the root cause is that
>> up->ctl_msg_buffer->raw is not NUL terminated.
>>
>> Because of that, a local copy was added, just to reintroduce the NUL
>> terminating byte.
>>
>> I think it is better to just directly terminate up->ctl_msg_buffer->raw
>> and get rid of the firmware_str local variable and the string copy.
>>
>> So, what about this:
>>
>> diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
>> index 39a63b7313a4..268085453d24 100644
>> --- a/drivers/net/can/usb/ucan.c
>> +++ b/drivers/net/can/usb/ucan.c
>> @@ -186,7 +186,7 @@ union ucan_ctl_payload {
>>          */
>>         struct ucan_ctl_cmd_get_protocol_version cmd_get_protocol_version;
>>
>> -       u8 raw[128];
>> +       char fw_info[128];
>>  } __packed;
>>
>>  enum {
>> @@ -424,18 +424,19 @@ static int ucan_ctrl_command_out(struct ucan_priv *up,
>>                                UCAN_USB_CTL_PIPE_TIMEOUT);
>>  }
>>
>> -static int ucan_device_request_in(struct ucan_priv *up,
>> -                                 u8 cmd, u16 subcmd, u16 datalen)
>> +static void ucan_get_fw_info(struct ucan_priv *up, char *fw_info,
>> size_t size)
>>  {
>> -       return usb_control_msg(up->udev,
>> -                              usb_rcvctrlpipe(up->udev, 0),
>> -                              cmd,
>> -                              USB_DIR_IN | USB_TYPE_VENDOR |
>> USB_RECIP_DEVICE,
>> -                              subcmd,
>> -                              0,
>> -                              up->ctl_msg_buffer,
>> -                              datalen,
>> -                              UCAN_USB_CTL_PIPE_TIMEOUT);
>> +       int ret;
>> +
>> +       ret = usb_control_msg(up->udev, usb_rcvctrlpipe(up->udev, 0),
>> +                             UCAN_DEVICE_GET_FW_STRING,
>> +                             USB_DIR_IN | USB_TYPE_VENDOR |
>> USB_RECIP_DEVICE,
>> +                             0, 0, fw_info, size - 1,
>> +                             UCAN_USB_CTL_PIPE_TIMEOUT);
>> +       if (ret > 0)
>> +               fw_info[ret] = '\0';
>> +       else
>> +               strcpy(fw_info, "unknown");
>>  }
>>
>>  /* Parse the device information structure reported by the device and
>> @@ -1314,7 +1315,6 @@ static int ucan_probe(struct usb_interface *intf,
>>         u8 in_ep_addr;
>>         u8 out_ep_addr;
>>         union ucan_ctl_payload *ctl_msg_buffer;
>> -       char firmware_str[sizeof(union ucan_ctl_payload) + 1];
>>
>>         udev = interface_to_usbdev(intf);
>>
>> @@ -1527,17 +1527,6 @@ static int ucan_probe(struct usb_interface *intf,
>>          */
>>         ucan_parse_device_info(up, &ctl_msg_buffer->cmd_get_device_info);
>>
>> -       /* just print some device information - if available */
>> -       ret = ucan_device_request_in(up, UCAN_DEVICE_GET_FW_STRING, 0,
>> -                                    sizeof(union ucan_ctl_payload));
>> -       if (ret > 0) {
>> -               /* copy string while ensuring zero termination */
>> -               strscpy(firmware_str, up->ctl_msg_buffer->raw,
>> -                       sizeof(union ucan_ctl_payload) + 1);
>> -       } else {
>> -               strcpy(firmware_str, "unknown");
>> -       }
>> -
>>         /* device is compatible, reset it */
>>         ret = ucan_ctrl_command_out(up, UCAN_COMMAND_RESET, 0, 0);
>>         if (ret < 0)
>> @@ -1555,7 +1544,10 @@ static int ucan_probe(struct usb_interface *intf,
>>
>>         /* initialisation complete, log device info */
>>         netdev_info(up->netdev, "registered device\n");
>> -       netdev_info(up->netdev, "firmware string: %s\n", firmware_str);
>> +       ucan_get_fw_info(up, up->ctl_msg_buffer->fw_info,
>> +                        sizeof(up->ctl_msg_buffer->fw_info));
>> +       netdev_info(up->netdev, "firmware string: %s\n",
>> +                   up->ctl_msg_buffer->fw_info);
> 
> We could also use the:
> 
>     printf("%.*s", sizeof(up->ctl_msg_buffer->fw_info), up->ctl_msg_buffer->fw_info);
> 
> format string trick to only print a limited number of chars of the given
> string.

Indeed. But after the renaming of ucan_device_request_in() into
ucan_get_fw_info(), it makes slightly more sense to me to have this new
function to handle the string NUL termination logic rather than to
deffer it to the format string.

But thanks for the suggestion.

> But I'm also fine with your solution. Either way, please send a
> proper patch :)

Will do so right now!


Yours sincerely,
Vincent Mailhol



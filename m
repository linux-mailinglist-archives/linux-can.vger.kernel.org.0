Return-Path: <linux-can+bounces-2824-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A47B8A390D9
	for <lists+linux-can@lfdr.de>; Tue, 18 Feb 2025 03:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D14A6188410E
	for <lists+linux-can@lfdr.de>; Tue, 18 Feb 2025 02:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F834315A;
	Tue, 18 Feb 2025 02:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="jgE1PVCM"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-70.smtpout.orange.fr [193.252.22.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E20286A1;
	Tue, 18 Feb 2025 02:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739845414; cv=none; b=cNTaGhATKs4wW1hduYbUs7LV4AkaTYP6y6N5i/q0Xn+z47jfuw3UwIAzEQWnCODVClNM+tGj+Xqh6P0Zw8b0j3/J/f0fBLO2cpsd6TupyxIyf3M0k+0TxCQkhQgbeWpHJryGNZ1psRzf5rY4+8aKgIAGIQo4DzC4ocRWS9U1Q4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739845414; c=relaxed/simple;
	bh=vi+ezaL3q6ML386BlLYDBuoOAdlqf0JMPGF1PaApdQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eqo8iszJ6Fh0/itptQkAOmUSjMKyXd+5RCoI2EmqC7naOvqifik5cJbPxGHGkdkszcsK4qNZFtPNiFcri3nwUWm+/3xTx3xijZz1jXcIn7NM2HBUAanbIVWyiP7Q0siq+2seYqyLCKz4RPdbVS94u+sHQItkQhoc+fE800BQc4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=jgE1PVCM; arc=none smtp.client-ip=193.252.22.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id kDFUtMr7WwhW2kDFYtuOeV; Tue, 18 Feb 2025 03:22:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1739845339;
	bh=f5pjnJVuN2RARGK/eLtkdQ2AY9d+D6FXv/r6YtancYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=jgE1PVCM0C1OIfAi2GH1BRssBXKGi/Gsgbs5h8UDO0ovUs7pIXEkmtCPr7BvOVg+3
	 8F7tBGSmmqkUoZTs+Ss4mwhNfwBZj5G33HkgN9pYUdskD8I1sb8fotOW8J6nFKOaQW
	 mfEbgVnv4iGcE2t5oDmzO+JhaZwX6rnATPI7nyl0FwFjQukD4zwjDea3rxpxXQrOO/
	 5O1FuSRx9XbSe/mxxMiSldcxbFos6ztZ5Eet8EdiGTsw/Rm0TpiVZzhi7IPANLX2Aa
	 zW42KPePS25QRltB5S6rTd8lc4iBV3+WTp0GwT/M5h1W7rF3MUovLPRHINBK3fM34S
	 akrQcHnGuC22g==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 18 Feb 2025 03:22:19 +0100
X-ME-IP: 124.33.176.97
Message-ID: <2f33170a-f7bb-47dd-8cb7-15c055dabc83@wanadoo.fr>
Date: Tue, 18 Feb 2025 11:22:11 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: ucan: Correct the size parameter
To: Matt Jan <zoo868e@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: syzbot+d7d8c418e8317899e88c@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, linux-can@vger.kernel.org
References: <67b323a4.050a0220.173698.002b.GAE@google.com>
 <20250217190404.354574-1-zoo868e@gmail.com>
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
In-Reply-To: <20250217190404.354574-1-zoo868e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 18/02/2025 at 04:04, Matt Jan wrote:
> According to the comment, the size parameter is only required when
> @dst is not an array, or when the copy needs to be smaller than
> sizeof(@dst). Since the source is a `union ucan_ctl_payload`, the
> correct size should be sizeof(union ucan_ctl_payload).

While this fix is correct, I think that the root cause is that
up->ctl_msg_buffer->raw is not NUL terminated.

Because of that, a local copy was added, just to reintroduce the NUL
terminating byte.

I think it is better to just directly terminate up->ctl_msg_buffer->raw
and get rid of the firmware_str local variable and the string copy.

So, what about this:

diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
index 39a63b7313a4..268085453d24 100644
--- a/drivers/net/can/usb/ucan.c
+++ b/drivers/net/can/usb/ucan.c
@@ -186,7 +186,7 @@ union ucan_ctl_payload {
         */
        struct ucan_ctl_cmd_get_protocol_version cmd_get_protocol_version;

-       u8 raw[128];
+       char fw_info[128];
 } __packed;

 enum {
@@ -424,18 +424,19 @@ static int ucan_ctrl_command_out(struct ucan_priv *up,
                               UCAN_USB_CTL_PIPE_TIMEOUT);
 }

-static int ucan_device_request_in(struct ucan_priv *up,
-                                 u8 cmd, u16 subcmd, u16 datalen)
+static void ucan_get_fw_info(struct ucan_priv *up, char *fw_info,
size_t size)
 {
-       return usb_control_msg(up->udev,
-                              usb_rcvctrlpipe(up->udev, 0),
-                              cmd,
-                              USB_DIR_IN | USB_TYPE_VENDOR |
USB_RECIP_DEVICE,
-                              subcmd,
-                              0,
-                              up->ctl_msg_buffer,
-                              datalen,
-                              UCAN_USB_CTL_PIPE_TIMEOUT);
+       int ret;
+
+       ret = usb_control_msg(up->udev, usb_rcvctrlpipe(up->udev, 0),
+                             UCAN_DEVICE_GET_FW_STRING,
+                             USB_DIR_IN | USB_TYPE_VENDOR |
USB_RECIP_DEVICE,
+                             0, 0, fw_info, size - 1,
+                             UCAN_USB_CTL_PIPE_TIMEOUT);
+       if (ret > 0)
+               fw_info[ret] = '\0';
+       else
+               strcpy(fw_info, "unknown");
 }

 /* Parse the device information structure reported by the device and
@@ -1314,7 +1315,6 @@ static int ucan_probe(struct usb_interface *intf,
        u8 in_ep_addr;
        u8 out_ep_addr;
        union ucan_ctl_payload *ctl_msg_buffer;
-       char firmware_str[sizeof(union ucan_ctl_payload) + 1];

        udev = interface_to_usbdev(intf);

@@ -1527,17 +1527,6 @@ static int ucan_probe(struct usb_interface *intf,
         */
        ucan_parse_device_info(up, &ctl_msg_buffer->cmd_get_device_info);

-       /* just print some device information - if available */
-       ret = ucan_device_request_in(up, UCAN_DEVICE_GET_FW_STRING, 0,
-                                    sizeof(union ucan_ctl_payload));
-       if (ret > 0) {
-               /* copy string while ensuring zero termination */
-               strscpy(firmware_str, up->ctl_msg_buffer->raw,
-                       sizeof(union ucan_ctl_payload) + 1);
-       } else {
-               strcpy(firmware_str, "unknown");
-       }
-
        /* device is compatible, reset it */
        ret = ucan_ctrl_command_out(up, UCAN_COMMAND_RESET, 0, 0);
        if (ret < 0)
@@ -1555,7 +1544,10 @@ static int ucan_probe(struct usb_interface *intf,

        /* initialisation complete, log device info */
        netdev_info(up->netdev, "registered device\n");
-       netdev_info(up->netdev, "firmware string: %s\n", firmware_str);
+       ucan_get_fw_info(up, up->ctl_msg_buffer->fw_info,
+                        sizeof(up->ctl_msg_buffer->fw_info));
+       netdev_info(up->netdev, "firmware string: %s\n",
+                   up->ctl_msg_buffer->fw_info);

        /* success */
        return 0;


> Signed-off-by: Matt Jan <zoo868e@gmail.com>
> Reported-by: syzbot+d7d8c418e8317899e88c@syzkaller.appspotmail.com
> Fixes: b3e40fc85735 ("USB: usb_parse_endpoint: ignore reserved bits")

I saw that the bot bisected it to this commit, but I doubt that this is
correct. In


https://lore.kernel.org/linux-can/20250217-spectral-cordial-booby-968731-mkl@pengutronix.de/

Marc pointed out that the issue came from 7fdaf8966aae ("can: ucan: use
strscpy() to instead of strncpy()"). And I agree with Marc's analysis.

> ---
>  drivers/net/can/usb/ucan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
> index 39a63b7313a4..1ccef00388ae 100644
> --- a/drivers/net/can/usb/ucan.c
> +++ b/drivers/net/can/usb/ucan.c
> @@ -1533,7 +1533,7 @@ static int ucan_probe(struct usb_interface *intf,
>  	if (ret > 0) {
>  		/* copy string while ensuring zero termination */
>  		strscpy(firmware_str, up->ctl_msg_buffer->raw,
> -			sizeof(union ucan_ctl_payload) + 1);
> +			sizeof(union ucan_ctl_payload));
>  	} else {
>  		strcpy(firmware_str, "unknown");
>  	}

Yours sincerely,
Vincent Mailhol



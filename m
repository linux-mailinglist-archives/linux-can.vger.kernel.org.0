Return-Path: <linux-can+bounces-4230-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8BCB248B6
	for <lists+linux-can@lfdr.de>; Wed, 13 Aug 2025 13:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01C5D726A90
	for <lists+linux-can@lfdr.de>; Wed, 13 Aug 2025 11:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED052F8BC1;
	Wed, 13 Aug 2025 11:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ft9PAAUo"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E832F83D9;
	Wed, 13 Aug 2025 11:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755085489; cv=none; b=tE2fX+lTdf3WI3D95yi/wJI0hh0jMmEyWwLC1JLkBp1NZCm6I2AbFwxeR2GbvM5UO8kdPEi8inWGMzFDbViffyakQ1L5mnnspfkMs/zBvPKzZDuN08n6uFED0BwcHqfL1LiouBzQApwUfJBGqh89ixpXDTMl6Q/R2li1wKxH8kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755085489; c=relaxed/simple;
	bh=w9T+UZHUVhxj9lkLnAyKjBTph+QMXw2J4VUWkLRMIjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=idRvogN4kEAnFHPUxdRK5G6Rjs4dDptvtvDwq0DNUH1dugTSmkdLhIxlqM0O6S9bvuaNOVdb6qwwqtWHBBUtJyHBGzRpat7nfaVKgxLQNRzqnwF+SXdli2swa4aPaVM3872I6ZR6G7r+r7/ieAzxJVFhSy7jOS7gPN5Je21VJzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ft9PAAUo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A3EC4CEF5;
	Wed, 13 Aug 2025 11:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755085489;
	bh=w9T+UZHUVhxj9lkLnAyKjBTph+QMXw2J4VUWkLRMIjM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ft9PAAUoxK4VcZeJyGaHT5X1lT8Te+B6lztfMNEwDmBJI6JKSl0Q10FoMeaF7uiMt
	 79D5mPMGVASxbVTUxiJ8kcODym6ZQwHcjBXZ4WpBmR/qDBOQ1sBAn9j5y22TwgkEcR
	 S9gYr4v5hUCln5KKPA8EI28pOGUVFRX1CzD9iDzaSDPQJibc2G85MyA7JMGtr/mewf
	 klCreOjaZAT1PrKlLv31kFqSGz1XPVf/Bn1wzMJq+k7x84IyQc2qrS5+7vuwYD8kLX
	 RCio4Vqcsfv/SPdQ4SwhIU9FtH2vTLIF2DXFoS7erTq92JUYJG0w0tUz2BmN9Z+NMw
	 r7NyHkAENe9Kg==
Message-ID: <bc15e28a-95e9-449f-aba2-d14aa599a125@kernel.org>
Date: Wed, 13 Aug 2025 20:44:43 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] can: esd_usb: Fix not detecting version reply in
 probe routine
To: =?UTF-8?Q?Stefan_M=C3=A4tje?= <stefan.maetje@esd.eu>
Cc: Frank Jungclaus <frank.jungclaus@esd.eu>, linux-can@vger.kernel.org,
 socketcan@esd.eu, Simon Horman <horms@kernel.org>,
 Olivier Sobrie <olivier@sobrie.be>, Oliver Hartkopp
 <socketcan@hartkopp.net>, netdev@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>
References: <20250811210611.3233202-1-stefan.maetje@esd.eu>
 <20250811210611.3233202-3-stefan.maetje@esd.eu>
 <20250813-just-independent-angelfish-909305-mkl@pengutronix.de>
Content-Language: en-US
From: Vincent Mailhol <mailhol@kernel.org>
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20250813-just-independent-angelfish-909305-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Stefan,

On 8/13/25 5:26 PM, Marc Kleine-Budde wrote:
> On 11.08.2025 23:06:07, Stefan Mätje wrote:
>> This patch fixes some problems in the esd_usb_probe routine that render
>> the CAN interface unusable.
>>
>> The probe routine sends a version request message to the USB device to
>> receive a version reply with the number of CAN ports and the hard-
>> & firmware versions. Then for each CAN port a CAN netdev is registered.
>>
>> The previous code assumed that the version reply would be received
>> immediately. But if the driver was reloaded without power cycling the
>> USB device (i. e. on a reboot) there could already be other incoming
>> messages in the USB buffers. These would be in front of the version
>> reply and need to be skipped.

Wouldn't it be easier to:

  - First empty the incoming USB message queue
  - Then request the version
  - Finally parse the version reply

?

This way, you wouldn't have to do the complex parsing anymore in
esd_usb_recv_version().

>> In the previous code these problems were present:
>> - Only one usb_bulk_msg() read was done into a buffer of
>>   sizeof(union esd_usb_msg) which is smaller than ESD_USB_RX_BUFFER_SIZE
>>   which could lead to an overflow error from the USB stack.
>> - The first bytes of the received data were taken without checking for
>>   the message type. This could lead to zero detected CAN interfaces.
>>
>> To mitigate these problems:
>> - Use a transfer buffer "buf" with ESD_USB_RX_BUFFER_SIZE.
>> - Added a function esd_usb_recv_version() that reads and skips incoming
>>   "esd_usb_msg" messages until a version reply message is found. This
>>   is evaluated to return the count of CAN ports and version information.
>> - The data drain loop is limited by a maximum # of bytes to read from
>>   the device based on its internal buffer sizes and a timeout
>>   ESD_USB_DRAIN_TIMEOUT_MS.
>>
>> This version of the patch incorporates changes recommended on the
>> linux-can list for a first version.
>>
>> References:
>> https://lore.kernel.org/linux-can/d7fd564775351ea8a60a6ada83a0368a99ea6b19.camel@esd.eu/#r
>>
>> Fixes: 80662d943075 ("can: esd_usb: Add support for esd CAN-USB/3")
>> Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
>> ---
>>  drivers/net/can/usb/esd_usb.c | 125 ++++++++++++++++++++++++++--------
>>  1 file changed, 97 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
>> index 05ed664cf59d..dbdfffe3a4a0 100644
>> --- a/drivers/net/can/usb/esd_usb.c
>> +++ b/drivers/net/can/usb/esd_usb.c
>> @@ -44,6 +44,9 @@ MODULE_LICENSE("GPL v2");
>>  #define ESD_USB_CMD_TS			5 /* also used for TS_REPLY */
>>  #define ESD_USB_CMD_IDADD		6 /* also used for IDADD_REPLY */
>>  
>> +/* esd version message name size */
>> +#define ESD_USB_FW_NAME_SZ 16
>> +
>>  /* esd CAN message flags - dlc field */
>>  #define ESD_USB_RTR	BIT(4)
>>  #define ESD_USB_NO_BRS	BIT(4)
>> @@ -95,6 +98,7 @@ MODULE_LICENSE("GPL v2");
>>  #define ESD_USB_RX_BUFFER_SIZE		1024
>>  #define ESD_USB_MAX_RX_URBS		4
>>  #define ESD_USB_MAX_TX_URBS		16 /* must be power of 2 */
>> +#define ESD_USB_DRAIN_TIMEOUT_MS	100
>>  
>>  /* Modes for CAN-USB/3, to be used for esd_usb_3_set_baudrate_msg_x.mode */
>>  #define ESD_USB_3_BAUDRATE_MODE_DISABLE		0 /* remove from bus */
>> @@ -131,7 +135,7 @@ struct esd_usb_version_reply_msg {
>>  	u8 nets;
>>  	u8 features;
>>  	__le32 version;
>> -	u8 name[16];
>> +	u8 name[ESD_USB_FW_NAME_SZ];
>>  	__le32 rsvd;
>>  	__le32 ts;
>>  };
>> @@ -625,17 +629,91 @@ static int esd_usb_send_msg(struct esd_usb *dev, union esd_usb_msg *msg)
>>  			    1000);
>>  }
>>  
>> -static int esd_usb_wait_msg(struct esd_usb *dev,
>> -			    union esd_usb_msg *msg)
>> +static int esd_usb_req_version(struct esd_usb *dev, void *buf)
>>  {
>> -	int actual_length;
>> +	union esd_usb_msg *msg = buf;
>>  
>> -	return usb_bulk_msg(dev->udev,
>> -			    usb_rcvbulkpipe(dev->udev, 1),
>> -			    msg,
>> -			    sizeof(*msg),
>> -			    &actual_length,
>> -			    1000);
>> +	msg->hdr.cmd = ESD_USB_CMD_VERSION;
>> +	msg->hdr.len = sizeof(struct esd_usb_version_msg) / sizeof(u32); /* # of 32bit words */
>> +	msg->version.rsvd = 0;
>> +	msg->version.flags = 0;
>> +	msg->version.drv_version = 0;
>> +
>> +	return esd_usb_send_msg(dev, msg);
>> +}
>> +
>> +static int esd_usb_recv_version(struct esd_usb *dev, void *rx_buf)
>> +{
>> +	/* Device hardware has 2 RX buffers with ESD_USB_RX_BUFFER_SIZE, * 4 to give some slack. */
>> +	const int max_drain_bytes = (4 * ESD_USB_RX_BUFFER_SIZE);
>> +	unsigned long end_jiffies;
>> +	int cnt_other = 0;
>> +	int cnt_ts = 0;
>> +	int cnt_vs = 0;
>> +	int len_sum = 0;
>> +	int attempt = 0;
>> +	int err;
>> +
>> +	end_jiffies = jiffies + msecs_to_jiffies(ESD_USB_DRAIN_TIMEOUT_MS);
>> +	do {
>> +		int actual_length;
>> +		int pos;
>> +
>> +		err = usb_bulk_msg(dev->udev,
>> +				   usb_rcvbulkpipe(dev->udev, 1),
>> +				   rx_buf,
>> +				   ESD_USB_RX_BUFFER_SIZE,
>> +				   &actual_length,
>> +				   ESD_USB_DRAIN_TIMEOUT_MS);
>> +		dev_dbg(&dev->udev->dev, "AT %d, LEN %d, ERR %d\n", attempt, actual_length, err);
>> +		if (err)
>> +			goto bail;
>> +
>> +		err = -ENOENT;
>> +		len_sum += actual_length;
>> +		pos = 0;
>> +		while (pos < actual_length) {
> 
> You have to check that the actual offset you will access later is within
> actual_length.
> 
>> +			union esd_usb_msg *p_msg;
>> +
>> +			p_msg = (union esd_usb_msg *)(rx_buf + pos);
>> +
>> +			switch (p_msg->hdr.cmd) {
>> +			case ESD_USB_CMD_VERSION:
>> +				++cnt_vs;
>> +				dev->net_count = min(p_msg->version_reply.nets, ESD_USB_MAX_NETS);
>> +				dev->version = le32_to_cpu(p_msg->version_reply.version);
>> +				err = 0;
>> +				dev_dbg(&dev->udev->dev, "TS 0x%08x, V 0x%08x, N %u, F 0x%02x, %.*s\n",
>> +					le32_to_cpu(p_msg->version_reply.ts),
>> +					le32_to_cpu(p_msg->version_reply.version),
>> +					p_msg->version_reply.nets,
>> +					p_msg->version_reply.features,
>> +					ESD_USB_FW_NAME_SZ, p_msg->version_reply.name);
>> +				break;
>> +			case ESD_USB_CMD_TS:
>> +				++cnt_ts;
>> +				dev_dbg(&dev->udev->dev, "TS 0x%08x\n",
>> +					le32_to_cpu(p_msg->rx.ts));
>> +				break;
>> +			default:
>> +				++cnt_other;
>> +				dev_dbg(&dev->udev->dev, "HDR %d\n", p_msg->hdr.cmd);
>> +				break;
>> +			}
>> +			pos += p_msg->hdr.len * sizeof(u32); /* convert to # of bytes */
> 
> Can pos overflow? hdr.len is a u8, so probably not.
> 
>> +			if (pos > actual_length) {
>> +				dev_err(&dev->udev->dev, "format error\n");
>> +				err = -EPROTO;
>> +				goto bail;
>> +			}
>> +		}
>> +		++attempt;
>> +	} while (cnt_vs == 0 && len_sum < max_drain_bytes && time_before(jiffies, end_jiffies));
>> +bail:
>> +	dev_dbg(&dev->udev->dev, "RC=%d; ATT=%d, TS=%d, VS=%d, O=%d, B=%d\n",
>> +		err, attempt, cnt_ts, cnt_vs, cnt_other, len_sum);
>> +	return err;
>>  }
>>  
>>  static int esd_usb_setup_rx_urbs(struct esd_usb *dev)
>> @@ -1274,7 +1352,7 @@ static int esd_usb_probe(struct usb_interface *intf,
>>  			 const struct usb_device_id *id)
>>  {
>>  	struct esd_usb *dev;
>> -	union esd_usb_msg *msg;
>> +	void *buf;
>>  	int i, err;
>>  
>>  	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
>> @@ -1289,34 +1367,25 @@ static int esd_usb_probe(struct usb_interface *intf,
>>  
>>  	usb_set_intfdata(intf, dev);
>>  
>> -	msg = kmalloc(sizeof(*msg), GFP_KERNEL);
>> -	if (!msg) {
>> +	buf = kmalloc(ESD_USB_RX_BUFFER_SIZE, GFP_KERNEL);
>> +	if (!buf) {
>>  		err = -ENOMEM;
>>  		goto free_dev;
>>  	}
>>  
>>  	/* query number of CAN interfaces (nets) */
>> -	msg->hdr.cmd = ESD_USB_CMD_VERSION;
>> -	msg->hdr.len = sizeof(struct esd_usb_version_msg) / sizeof(u32); /* # of 32bit words */
>> -	msg->version.rsvd = 0;
>> -	msg->version.flags = 0;
>> -	msg->version.drv_version = 0;
>> -
>> -	err = esd_usb_send_msg(dev, msg);
>> +	err = esd_usb_req_version(dev, buf);
> 
> I'm a bit uneasy with the passing of the buffer as an argument, but not
> its size.

+1

What I also do not like is that buffer of type void *. If I understand
correctly, you are using this buffer for both the request and the reply, thus
the void* type. But is this really a winning trade?

Here we are in the probe function, not something speed critical. So, I would
rather have the esd_usb_req_version() and the esd_usb_recv_version() allocate
their own buffer with the correct size.

Yes, you would be doing two kalloc() instead of one, but you will gain in
readability and the esd_usb_probe() also becomes simpler.

>>  	if (err < 0) {
>>  		dev_err(&intf->dev, "sending version message failed\n");
>> -		goto free_msg;
>> +		goto free_buf;
>>  	}
>>  
>> -	err = esd_usb_wait_msg(dev, msg);
>> +	err = esd_usb_recv_version(dev, buf);
>>  	if (err < 0) {
>>  		dev_err(&intf->dev, "no version message answer\n");
>> -		goto free_msg;
>> +		goto free_buf;
>>  	}
>>  
>> -	dev->net_count = (int)msg->version_reply.nets;
>> -	dev->version = le32_to_cpu(msg->version_reply.version);
>> -
>>  	if (device_create_file(&intf->dev, &dev_attr_firmware))
>>  		dev_err(&intf->dev,
>>  			"Couldn't create device file for firmware\n");
>> @@ -1333,8 +1402,8 @@ static int esd_usb_probe(struct usb_interface *intf,
>>  	for (i = 0; i < dev->net_count; i++)
>>  		esd_usb_probe_one_net(intf, i);
>>  
>> -free_msg:
>> -	kfree(msg);
>> +free_buf:
>> +	kfree(buf);
>>  free_dev:
>>  	if (err)
>>  		kfree(dev);
-- 
Yours sincerely,
Vincent Mailhol



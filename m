Return-Path: <linux-can+bounces-935-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2795D91E4AD
	for <lists+linux-can@lfdr.de>; Mon,  1 Jul 2024 17:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F8C01C21420
	for <lists+linux-can@lfdr.de>; Mon,  1 Jul 2024 15:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052A116D4C0;
	Mon,  1 Jul 2024 15:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgiSfVDh"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BC1126F1E
	for <linux-can@vger.kernel.org>; Mon,  1 Jul 2024 15:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719849338; cv=none; b=XrFvDL6gt5JtjM7LS/VhwxsJasdU22DMVnATZIkF1kpmkuIUQPLFIEyNup9/jCVeE2rIDTaE6kI8EofBvCqBxxK/ha5XlUrF6Jabu+jWMOf6d9JpIsf70un0ic8nED2zmJdi2BS+sN8By1g5Ijd8jwGjv46nBxitcpRYKZfY6S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719849338; c=relaxed/simple;
	bh=zsSD3SVfS1QqK5Mt59E6q3eMcBkhVTs0QokNMxWo988=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HoMRPNa8S+YD8qCFMtLbNXuynfEYO7n9hybgQ6nyQLq6FW5Q3yecy2b0MngJrEzSj2mDinWMmMhM9KzL1D3iTPijegdRouSotEW1+nxe824aYHa3lyVC7ZTi8uAQRjknvSr4hHxmqWIvYBkXmbT1fTwfvE+Q/To5838DMAa4Avo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgiSfVDh; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57d4ee2aaabso557443a12.2
        for <linux-can@vger.kernel.org>; Mon, 01 Jul 2024 08:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719849335; x=1720454135; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VDj4a0O9LJQCCoD/N7IBSfmRCr7pE/U4d9jajdc7F4k=;
        b=jgiSfVDhgoGVPsweIZOq2QTHUnPz08OR28tcjtma1H5Us4mkw/8liprUh09spF9bZN
         NTH1ZTqBBLBNWKeSCkaocKAcQ81zr04CQWXyxk9vHjqC69t9s65N+HlVT2cf9hlufUZf
         V+S+k1MzkwNUjRNBTK+QcYR5pK/gsGLzP3GiKLNeYboofYR3rscfZL0X12IYc7Anbrgj
         mRQgxIAMYfWmSF4Z63Bjx/zPj67gIHPCHpO157eyXt8hzbyRF+k0+MInWb8o6DT+9nv7
         JwJTlevv94HfuyCQLtgvjizoUHA20xFrGrOQ8TYQU6aWkmLTalMjSyhmTCj6NBfu2JiP
         RBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719849335; x=1720454135;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VDj4a0O9LJQCCoD/N7IBSfmRCr7pE/U4d9jajdc7F4k=;
        b=PcOejjIrH4jHZX92LMzhVg0dBEUDmeE52vz/0uomP2JwNnobyd/kFr7kalF3eevCNY
         UUXYXOXDOhaB/yRu6Xa/S7VGYMDDatQzP34Ge9Rs8cOG/H4ka+uN6pnK+rmWH4TbIKpK
         TFkV0K0mw/8ZNq4tZIZNhQ3qfWV345Uug1sKSLV+0RKJsK7bSHcd/9oA+q4KykFixI8p
         eo2QQfRkt9Qyip/g/hZV/h/UOaVZCCGCfTScB210NsyfrNs1yn3yu0Cbh0eHzz5HGZIy
         C1pZkwoTp5w5sQHDnx0ZMw/rBk+PiJCqAUzhugdsjUxvw195epug6a5VHLySJYb3ZzDM
         FVWg==
X-Gm-Message-State: AOJu0YxgvDscw4jTxSUCSlhIo3+bZSwiOX/1QsgzkGjalOh5sys0KW+K
	E0TrOWHm6vdYIVjFS6lKMJrxcVnxesIAYGODw9yjoZJwyl/B5MXtxSTmRA==
X-Google-Smtp-Source: AGHT+IGgjv66Ry7GeuaOXOC5J4Bff6bUlczEGNWVw/z+IhCjaLmviv8ln0HC12Xt8B8/8VuTejaexg==
X-Received: by 2002:a17:906:730b:b0:a6f:bae6:f56c with SMTP id a640c23a62f3a-a75142d853dmr505070866b.3.1719849335243;
        Mon, 01 Jul 2024 08:55:35 -0700 (PDT)
Received: from [192.168.66.194] (h-98-128-173-232.A785.priv.bahnhof.se. [98.128.173.232])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a72aaf6398csm343894466b.83.2024.07.01.08.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 08:55:34 -0700 (PDT)
Message-ID: <1564ee27-8216-ca3a-06b1-e8b7838d11fa@gmail.com>
Date: Mon, 1 Jul 2024 17:55:32 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH can-next 02/15] can: kvaser_usb: hydra: Add struct for Tx
 ACK commands
To: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
 Jimmy Assarsson <extja@kvaser.com>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
References: <20240628195514.316895-1-extja@kvaser.com>
 <20240628195514.316895-3-extja@kvaser.com>
 <CAMZ6RqKSa-6KjvgfmN9eL7A=A65gMkYsRrnaF41Azhsc45FA2Q@mail.gmail.com>
Content-Language: en-US
From: Jimmy Assarsson <jimmyassarsson@gmail.com>
In-Reply-To: <CAMZ6RqKSa-6KjvgfmN9eL7A=A65gMkYsRrnaF41Azhsc45FA2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/29/24 11:31, Vincent MAILHOL wrote:
> On Sat. 29 June 2024 at 04:56, Jimmy Assarsson <extja@kvaser.com> wrote:
>> Add, struct kvaser_cmd_tx_ack, for standard Tx ACK commands.
>>
>> Expand kvaser_usb_hydra_ktime_from_cmd() to extract timestamps from both
>> standard and extended Tx ACK commands. Unsupported commands are silently
>> ignored, and 0 is returned.
>>
>> Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
>> ---
>>   .../net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 23 ++++++++++++++++---
>>   1 file changed, 20 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
>> index a971fcb6158a..0be1cfe8d964 100644
>> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
>> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
>> @@ -261,6 +261,15 @@ struct kvaser_cmd_tx_can {
>>          u8 reserved[11];
>>   } __packed;
>>
>> +struct kvaser_cmd_tx_ack {
>> +       __le32 id;
>> +       u8 data[8];
>> +       u8 dlc;
>> +       u8 flags;
>> +       __le16 timestamp[3];
>> +       u8 reserved0[8];
>> +} __packed;
>> +
>>   struct kvaser_cmd_header {
>>          u8 cmd_no;
>>          /* The destination HE address is stored in 0..5 of he_addr.
>> @@ -297,6 +306,7 @@ struct kvaser_cmd {
>>
>>                  struct kvaser_cmd_rx_can rx_can;
>>                  struct kvaser_cmd_tx_can tx_can;
>> +               struct kvaser_cmd_tx_ack tx_ack;
>>          } __packed;
>>   } __packed;
>>
>> @@ -525,16 +535,23 @@ kvaser_usb_hydra_net_priv_from_cmd(const struct kvaser_usb *dev,
>>   static ktime_t kvaser_usb_hydra_ktime_from_cmd(const struct kvaser_usb_dev_cfg *cfg,
>>                                                 const struct kvaser_cmd *cmd)
>>   {
>> -       u64 ticks;
>> +       u64 ticks = 0;
>>
>>          if (cmd->header.cmd_no == CMD_EXTENDED) {
>>                  struct kvaser_cmd_ext *cmd_ext = (struct kvaser_cmd_ext *)cmd;
>>
>> -               ticks = le64_to_cpu(cmd_ext->rx_can.timestamp);
>> -       } else {
>> +               if (cmd_ext->cmd_no_ext == CMD_RX_MESSAGE_FD)
>> +                       ticks = le64_to_cpu(cmd_ext->rx_can.timestamp);
>> +               else if (cmd_ext->cmd_no_ext == CMD_TX_ACKNOWLEDGE_FD)
>> +                       ticks = le64_to_cpu(cmd_ext->tx_ack.timestamp);
>> +       } else if (cmd->header.cmd_no == CMD_RX_MESSAGE) {
>>                  ticks = le16_to_cpu(cmd->rx_can.timestamp[0]);
>>                  ticks += (u64)(le16_to_cpu(cmd->rx_can.timestamp[1])) << 16;
>>                  ticks += (u64)(le16_to_cpu(cmd->rx_can.timestamp[2])) << 32;
>> +       } else if (cmd->header.cmd_no == CMD_TX_ACKNOWLEDGE) {
>> +               ticks = le16_to_cpu(cmd->tx_ack.timestamp[0]);
>> +               ticks += (u64)(le16_to_cpu(cmd->tx_ack.timestamp[1])) << 16;
>> +               ticks += (u64)(le16_to_cpu(cmd->tx_ack.timestamp[2])) << 32;
> 
> Nitpick: the conversion of teh timestamp[3] array to the u64 tick is
> now duplicated. Maybe worth adding a
> 
>    kvaser_usb_hydra_convert_timestamp_to_ktime(__le16 *timestamp, u64 ticks);
> 
> helper function to factorize this and the ns_to_ktime() all together?
> 
> If you do so, it is better to add the new patch before this one.

Hi Vincent,

I'll fix this in v2. I've added two new helper functions kvaser_usb_timestamp{48,64}_to_ktime(),
that will convert from 48-bit and 64-bit device timestamps to to ktime [1]

Thanks for the comments!

Regards,
jimmy

[1] https://lore.kernel.org/linux-can/20240701154936.92633-2-extja@kvaser.com/T/#u

> 
>>          }
>>
>>          return ns_to_ktime(div_u64(ticks * 1000, cfg->timestamp_freq));
>> --
>> 2.45.2
>>
>>


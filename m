Return-Path: <linux-can+bounces-4550-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6654B4A5A5
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 10:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A4E21897EBD
	for <lists+linux-can@lfdr.de>; Tue,  9 Sep 2025 08:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A685027453;
	Tue,  9 Sep 2025 08:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="mClsVBbc";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="XJy2Vmr9"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11635253B56
	for <linux-can@vger.kernel.org>; Tue,  9 Sep 2025 08:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757407252; cv=pass; b=eH1jlRcLj7imHUINWXgi47KKm4qKAcRrJtfoJTR34WpOIYXSS7VswUvDUxKa7BDi8OAn6NhuSneJ2XbooW+WZOHWRZfXMTTuPfdB01CNuQxD83FBHCp8djxiv/0YXltT3WFrX3KLRJZQmR9b+wW2/wdxsujkvvWWvCD1bOAQ4v0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757407252; c=relaxed/simple;
	bh=ZUkR1xrQIN1H5Ogtl+rSFMa3Z00RPXD+BaAzQV7AQBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d9oyzJZMH9aD09p82QKnyyUWYq2Gi4KDnlQRhDZNIuDARw4RLRDMgzWARftg8mAjbhVL5G5uuswfGrP2eJgdxLC/WRD3rqHrEwSOb+ARFj/ADflzPPFTTwpjKeaEPfD4pBA2ASsgXAOTHtwPQ3s6T/rxBL1JHceAjnlLWzCKy60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=mClsVBbc; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=XJy2Vmr9; arc=pass smtp.client-ip=85.215.255.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1757407248; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ppDnMOvS96qaElGDNfjD2+ifaPZIo0/N0t+TzCZs6Gb4omEVmHcXBFXKbL/EU/Qwke
    hQ3robmMAI2UB5cx1b6EYTlIzhPJIMnuscijqaBS1UzB+yl7ZyjPucOqX8TO9OLarWGX
    +nFV9XxcCS1kw78+HA/ogyzhWBO96QhPj/VoUR1ajG8ufQBPgMKb1oLnF3Kyd1ZWYNWt
    CpMCxcgIy/gS7rtGcMplGOcn0ZW+RXXnk5nQ0akgDR3v3ZRVUDjmCZtpdhVaxXTenPOh
    JhoR2Bk9PYFbM4oThAUYVHmG7VUjK+pgfFygGeCiAqeHh4ZEHYZl+v55HvHCIIYebafH
    sXEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1757407248;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=iU2dMC1lld0hFTl4BJuEOjxVH7Dp+vizr5lq8KaYB0s=;
    b=ROm++vVKNlQMHnLADsoEb0Ds2imf/334CAguTKRNQSRcxqH/1+FNPW0G9mPLZFbOky
    28Q4rjn5UyU8mGz4qiZbOXtC3Nd6pSNuCnX8aaXvdQ0is3OnJDCWnlD1jETQytkboyfp
    f38TrG06cSjIdGj2Xz2Bwe5S5TGXctfflFtENNiBOIMT5Yt+lK3SBm50Z8WwFnsw9FCv
    x64VkwN+iih49GaHnJ9X7XCal5to6y6mrKXZnehOje0gctgmucKTlh7IxZrI2DDx7NXh
    NirufS8wwXsS4h7t/KdxAVBJPVrSpYDhLgjXNY4jTcwD3iQzlPTBbanFVN7QAqP6iqXw
    BdxA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1757407247;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=iU2dMC1lld0hFTl4BJuEOjxVH7Dp+vizr5lq8KaYB0s=;
    b=mClsVBbcD/xqgAPxNqvIlwDMk+WF6Ui8btswLIBXGMy9yxnuniMHaQB1venhnMGbOp
    FscBx5tz+3pbN7GyxkxSa8qUdF4hNxukEyfPuLNDrZEAbaEUfOwy41ZH5i/A4QknoXxd
    AOmvUqTDv1aNOl9JRht0zBDZxRtP7uuQYdDpNAvNZf5sXyw/lPiytxGJ7q2A+V2ILAoX
    /9WTycbNJHHF8pfbKRP2Mt0x1vlMcEDYt5iLuPJPJu5XrM5VdhOIxDLYtmjwCjbmCSn3
    hXkZtGwxoMCTfGeNWzwHejBwPy0BGhwldHPh70nTZmzdFuiHqYVHe9kWpoYcSuswtRIk
    z46g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1757407247;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=iU2dMC1lld0hFTl4BJuEOjxVH7Dp+vizr5lq8KaYB0s=;
    b=XJy2Vmr9Kj/UJwyW29cMja6aOxBm9cUhNrGrwDH7nuRXBQ9Pe71b4woR8Su1S7ocoT
    5EhiwQdwfznDgYWwxQBg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 52.1.2 AUTH)
    with ESMTPSA id K5d3611898eleer
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 9 Sep 2025 10:40:47 +0200 (CEST)
Message-ID: <d8bd5995-f517-4f99-814e-db674745f4cb@hartkopp.net>
Date: Tue, 9 Sep 2025 10:40:47 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 2/2] can: support XL only content on real CAN XL
 interfaces
To: Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org
References: <20250908184512.78449-1-socketcan@hartkopp.net>
 <20250908184512.78449-2-socketcan@hartkopp.net>
 <CAMZ6RqLY6a2wd=xdBLx16YmhafawWCW2tV0Wzj4oRJJJ15Vfzg@mail.gmail.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAMZ6RqLY6a2wd=xdBLx16YmhafawWCW2tV0Wzj4oRJJJ15Vfzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09.09.25 08:31, Vincent Mailhol wrote:
> On Tue. 9 Sep. 2025 at 03:48, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>> The CAN XL devices can be configured as CAN XL only with 'xl on fd off'
>> which is currently not supported as the CAN XL sockopt on the CAN_RAW
>> socket implicitly enables CAN FD support.
>>
>> This patch removes this XL/FD connection for real CAN XL interfaces and
>> rejects CAN FD content on CAN XL interfaces with 'fd off'.
>>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> ---
>>   include/linux/can/dev.h | 12 ++++++++++++
>>   net/can/raw.c           | 32 ++++++++++++++------------------
>>   2 files changed, 26 insertions(+), 18 deletions(-)
>>
>> diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
>> index 9a92cbe5b2cb..9fa139cc793e 100644
>> --- a/include/linux/can/dev.h
>> +++ b/include/linux/can/dev.h
>> @@ -183,10 +183,22 @@ struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
>>   void free_candev(struct net_device *dev);
>>
>>   /* a candev safe wrapper around netdev_priv */
>>   struct can_priv *safe_candev_priv(struct net_device *dev);
>>
>> +static inline bool can_dev_ctrlmode_fd_on(struct net_device *dev)
>> +{
>> +       struct can_priv *priv = safe_candev_priv(dev);
>> +
>> +       /* check ctrlmode on real CAN interfaces */
>> +       if (priv)
>> +               return (priv->ctrlmode & CAN_CTRLMODE_FD);
>> +
>> +       /* virtual CAN FD/XL interfaces always support CAN FD */
>> +       return true;
>> +}
>> +
>>   int open_candev(struct net_device *dev);
>>   void close_candev(struct net_device *dev);
>>   int can_change_mtu(struct net_device *dev, int new_mtu);
>>   int can_eth_ioctl_hwts(struct net_device *netdev, struct ifreq *ifr, int cmd);
>>   int can_ethtool_op_get_ts_info_hwts(struct net_device *dev,
>> diff --git a/net/can/raw.c b/net/can/raw.c
>> index f48b1f3fd6e8..6cd1f9cb050d 100644
>> --- a/net/can/raw.c
>> +++ b/net/can/raw.c
>> @@ -558,11 +558,10 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>>          struct raw_sock *ro = raw_sk(sk);
>>          struct can_filter *filter = NULL;  /* dyn. alloc'ed filters */
>>          struct can_filter sfilter;         /* single filter */
>>          struct net_device *dev = NULL;
>>          can_err_mask_t err_mask = 0;
>> -       int fd_frames;
>>          int count = 0;
>>          int err = 0;
>>
>>          if (level != SOL_CAN_RAW)
>>                  return -EINVAL;
>> @@ -698,33 +697,25 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>>                          return -EFAULT;
>>
>>                  break;
>>
>>          case CAN_RAW_FD_FRAMES:
>> -               if (optlen != sizeof(fd_frames))
>> +               if (optlen != sizeof(ro->fd_frames))
>>                          return -EINVAL;
>>
>> -               if (copy_from_sockptr(&fd_frames, optval, optlen))
>> +               if (copy_from_sockptr(&ro->fd_frames, optval, optlen))
>>                          return -EFAULT;
>>
>> -               /* Enabling CAN XL includes CAN FD */
>> -               if (ro->xl_frames && !fd_frames)
>> -                       return -EINVAL;
>> -
>> -               ro->fd_frames = fd_frames;
>>                  break;
>>
>>          case CAN_RAW_XL_FRAMES:
>>                  if (optlen != sizeof(ro->xl_frames))
>>                          return -EINVAL;
>>
>>                  if (copy_from_sockptr(&ro->xl_frames, optval, optlen))
>>                          return -EFAULT;
>>
>> -               /* Enabling CAN XL includes CAN FD */
>> -               if (ro->xl_frames)
>> -                       ro->fd_frames = ro->xl_frames;
>>                  break;
> 
> I think this is a UAPI breaking change. Any previous code which would
> have only set CAN_RAW_XL_FRAMES to implicitly also set
> CAN_RAW_FD_FRAMES would now break. I think it is an acceptable
> compromise, but, at least, we should make it crystal clear in the
> patch description that this is an UAPI breakage and clarify what the
> impacts are for the end user.
> 

Yes it is. And after another night I realized that it breaks the rule, 
that with every extension CC -> FD -> XL the former protocol types were 
covered.

So I removed this change in setsockopt() in v4.

The other feature to reject FD traffic on CAN XL interface with 'fd off' 
is now the only topic for that patch.

Best regards,
Oliver

>>          case CAN_RAW_XL_VCID_OPTS:
>>                  if (optlen != sizeof(ro->raw_vcid_opts))
>>                          return -EINVAL;
>> @@ -879,24 +870,29 @@ static void raw_put_canxl_vcid(struct raw_sock *ro, struct sk_buff *skb)
>>                  cxl->prio &= CANXL_PRIO_MASK;
>>                  cxl->prio |= ro->tx_vcid_shifted;
>>          }
>>   }
>>
>> -static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff *skb, int mtu)
>> +static unsigned int raw_check_txframe(struct raw_sock *ro, struct sk_buff *skb, struct net_device *dev)
>>   {
>>          /* Classical CAN -> no checks for flags and device capabilities */
>>          if (can_is_can_skb(skb))
>>                  return CAN_MTU;
>>
>> -       /* CAN FD -> needs to be enabled and a CAN FD or CAN XL device */
>> -       if (ro->fd_frames && can_is_canfd_skb_set_fdf(skb) &&
>> -           (mtu == CANFD_MTU || can_is_canxl_dev_mtu(mtu)))
>> -               return CANFD_MTU;
>> +       /* CAN FD -> needs to be enabled in a CAN FD or CAN XL device */
>> +       if (ro->fd_frames && can_is_canfd_skb_set_fdf(skb)) {
>> +               /* real/virtual CAN FD interface */
>> +               if (dev->mtu == CANFD_MTU)
>> +                       return CANFD_MTU;
>> +               if (can_is_canxl_dev_mtu(dev->mtu) &&
>> +                   can_dev_ctrlmode_fd_on(dev))
>> +                       return CANFD_MTU;
>> +       }
>>
>>          /* CAN XL -> needs to be enabled and a CAN XL device */
>>          if (ro->xl_frames && can_is_canxl_skb(skb) &&
>> -           can_is_canxl_dev_mtu(mtu))
>> +           can_is_canxl_dev_mtu(dev->mtu))
>>                  return CANXL_MTU;
>>
>>          return 0;
>>   }
>>
>> @@ -948,11 +944,11 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>>                  goto free_skb;
>>
>>          err = -EINVAL;
>>
>>          /* check for valid CAN (CC/FD/XL) frame content */
>> -       txmtu = raw_check_txframe(ro, skb, dev->mtu);
>> +       txmtu = raw_check_txframe(ro, skb, dev);
>>          if (!txmtu)
>>                  goto free_skb;
>>
>>          /* only CANXL: clear/forward/set VCID value */
>>          if (txmtu == CANXL_MTU)



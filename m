Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02AF740391C
	for <lists+linux-can@lfdr.de>; Wed,  8 Sep 2021 13:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351496AbhIHLsa (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 8 Sep 2021 07:48:30 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.21]:15639 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235453AbhIHLs3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 8 Sep 2021 07:48:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1631101274;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=vICPotDTkR0EPZc/xFZ/lC78gTMwEGwEaXyPToku3/E=;
    b=P+uUbc72Om+KyE/lJE0rKSnmloaVT1hy6plZYBB4H4JD8DgZp3YdGNeAHF/CepJ3Kj
    a9SdzD6bGvzXuHIIh7GfBYn916IAjLTHEvQft+C+zEqJHSrd5fnr0O0gW0aA2JsYN9jw
    XxcmA21SalG3XKYSkbLoQPMYnOgMVMSD+f8tKUZWRP20wMlAWwVKa8FT9bklhe8w6wTP
    mJEyEWJ0UOCd4BJDtxTktveE3dw9fAKnSWGhjkshnk4HNT5+La7aTHF3iB56262hb9mv
    DNpy+wXoA9zbCN0MpXIpnM0crisj0vaHIYx9sr/oT6pkm64RlbLHgkii7P8mYRqVhMf8
    a0/Q==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdd0DIgVuBOfXW6v7w=="
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2a00:6020:1cfa:f900::b82]
    by smtp.strato.de (RZmta 47.33.0 AUTH)
    with ESMTPSA id i0a93fx88BfEL3V
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 8 Sep 2021 13:41:14 +0200 (CEST)
Subject: Re: [PATCH v3 1/2] can: netlink: prevent incoherent can configuration
 in case of early return
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>
References: <20210906160310.54831-1-mailhol.vincent@wanadoo.fr>
 <20210906160310.54831-2-mailhol.vincent@wanadoo.fr>
 <CAMZ6RqJaY_jRv+AZ6oH6rxP=dE9Vs1fBwhBQJq_o3dgMWM1vUg@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <bccb03f4-5179-895a-f803-5adf543a8c19@hartkopp.net>
Date:   Wed, 8 Sep 2021 13:41:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAMZ6RqJaY_jRv+AZ6oH6rxP=dE9Vs1fBwhBQJq_o3dgMWM1vUg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

- nextdev ML
- linux-kernel ML

Hi Vincent,

On 07.09.21 14:51, Vincent MAILHOL wrote:
> On Tue. 7 Sep. 2021 at 01:03, Vincent Mailhol
> <mailhol.vincent@wanadoo.fr> wrote:
>> struct can_priv has a set of flags (can_priv::ctrlmode) which are
>> correlated with the other fields of the structure. In
>> can_changelink(), those flags are set first and copied to can_priv. If
>> the function has to return early, for example due to an out of range
>> value provided by the user, then the global configuration might become
>> incoherent.
>>
>> Example: the user provides an out of range dbitrate (e.g. 20
>> Mbps). The command fails (-EINVAL), however the FD flag was already
>> set resulting in a configuration where FD is on but the databittiming
>> parameters are empty.

When the ip configuration fails you get an error code. And you 
*typically* do it again to fix your wrong command line parameters.

¯\_(ツ)_/¯

If not the attempt to set the CAN interface to 'up' will fail (as the 
last line of defense).

The code with all the sanity checks is already pretty complex IMO.

I wonder if this effort is worth it.

Best regards,
Oliver



>>
>> * Illustration of above example *
>>
>> | $ ip link set can0 type can bitrate 500000 dbitrate 20000000 fd on
>> | RTNETLINK answers: Invalid argument
>> | $ ip --details link show can0
>> | 1: can0: <NOARP,ECHO> mtu 72 qdisc noop state DOWN mode DEFAULT group default qlen 10
>> |     link/can  promiscuity 0 minmtu 0 maxmtu 0
>> |     can <FD> state STOPPED restart-ms 0
>>             ^^ FD flag is set without any of the databittiming parameters...
>> |         bitrate 500000 sample-point 0.875
>> |         tq 12 prop-seg 69 phase-seg1 70 phase-seg2 20 sjw 1
>> |         ES582.1/ES584.1: tseg1 2..256 tseg2 2..128 sjw 1..128 brp 1..512 brp-inc 1
>> |         ES582.1/ES584.1: dtseg1 2..32 dtseg2 1..16 dsjw 1..8 dbrp 1..32 dbrp-inc 1
>> |         clock 80000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535
>>
>> To prevent this from happening, we do a local copy of can_priv, work
>> on it, an copy it at the very end of the function (i.e. only if all
>> previous checks succeeded).
>>
>> Once this done, there is no more need to have a temporary variable for
>> a specific parameter. As such, the bittiming and data bittiming (bt
>> and dbt) are directly written to the temporary priv variable.
>>
>>
>> N.B. The temporary can_priv is too big to be allocated on the stack
>> because, on x86_64 sizeof(struct can_priv) is 448 and:
>>
>> | $ objdump -d drivers/net/can/dev/netlink.o | ./scripts/checkstack.pl
>> | 0x00000000000002100 can_changelink []:            1200
>>
>>
>> Fixes: 9859ccd2c8be ("can: introduce the data bitrate configuration for CAN FD")
>> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>> ---
>>   drivers/net/can/dev/netlink.c | 32 ++++++++++++++++++--------------
>>   1 file changed, 18 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
>> index 80425636049d..21b76ca8cb22 100644
>> --- a/drivers/net/can/dev/netlink.c
>> +++ b/drivers/net/can/dev/netlink.c
>> @@ -58,14 +58,19 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
>>                            struct nlattr *data[],
>>                            struct netlink_ext_ack *extack)
>>   {
>> -       struct can_priv *priv = netdev_priv(dev);
>> +       /* Work on a local copy of priv to prevent inconsistent value
>> +        * in case of early return.
>> +        */
>> +       static struct can_priv *priv;
>>          int err;
>>
>>          /* We need synchronization with dev->stop() */
>>          ASSERT_RTNL();
>>
>> +       priv = kmemdup(netdev_priv(dev), sizeof(*priv), GFP_KERNEL);
>> +
>>          if (data[IFLA_CAN_BITTIMING]) {
>> -               struct can_bittiming bt;
>> +               struct can_bittiming *bt = &priv->bittiming;
>>
>>                  /* Do not allow changing bittiming while running */
>>                  if (dev->flags & IFF_UP)
>> @@ -79,22 +84,20 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
>>                  if (!priv->bittiming_const && !priv->do_set_bittiming)
>>                          return -EOPNOTSUPP;
>>
>> -               memcpy(&bt, nla_data(data[IFLA_CAN_BITTIMING]), sizeof(bt));
>> -               err = can_get_bittiming(dev, &bt,
>> +               memcpy(bt, nla_data(data[IFLA_CAN_BITTIMING]), sizeof(*bt));
>> +               err = can_get_bittiming(dev, bt,
>>                                          priv->bittiming_const,
>>                                          priv->bitrate_const,
>>                                          priv->bitrate_const_cnt);
>>                  if (err)
>>                          return err;
>>
>> -               if (priv->bitrate_max && bt.bitrate > priv->bitrate_max) {
>> +               if (priv->bitrate_max && bt->bitrate > priv->bitrate_max) {
>>                          netdev_err(dev, "arbitration bitrate surpasses transceiver capabilities of %d bps\n",
>>                                     priv->bitrate_max);
>>                          return -EINVAL;
>>                  }
>>
>> -               memcpy(&priv->bittiming, &bt, sizeof(bt));
>> -
>>                  if (priv->do_set_bittiming) {
>>                          /* Finally, set the bit-timing registers */
>>                          err = priv->do_set_bittiming(dev);
> 
> Actually, there is a big issue with my approach: the
> do_set_bittiming() and some other callback functions need to
> access priv. However, the changes being in the temporary
> variable, these will not be visible by the device.
> 
> I will rework all that a little bit more before sending v4.
> 
> 
> Yours sincerely,
> Vincent Mailhol
> 

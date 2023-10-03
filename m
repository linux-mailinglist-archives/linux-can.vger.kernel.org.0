Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9025B7B69EA
	for <lists+linux-can@lfdr.de>; Tue,  3 Oct 2023 15:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjJCNMo (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 3 Oct 2023 09:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjJCNMo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 3 Oct 2023 09:12:44 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C1E90
        for <linux-can@vger.kernel.org>; Tue,  3 Oct 2023 06:12:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1696338758; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ZsvjNZLeR06ovNKCz2VWLXY/ycrp63R6w/QnqSEvn2ocZZytnacLhFDnIIKrSQxdgd
    IE8myp3Tux5R3+nEXDASUEYJx6ou199DxjnrlOVXLXq15bkrSC0dml6iGH8FfiEsoE2b
    vmeLK5wmOWuqnVJPryF4Wtjzl3lzjDocJIf2wYe8IPzkwHEfCkaADkdF5mBMeCFSDTQw
    PF0qU/Q5snFRhIHUJ5moZb4Y8FlXRxGdVzi6tnZMoGRuQQANmXFV4a5TH5thAPlLgmkk
    hnkC09IpoMie/aoqwuQf2+AXoGj3H1geDwcIqm0iYEp+1HSR+B/vEbjx9yyCR7zTg4yT
    BdWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1696338758;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=X/PO7DAkjkJbhT9/ApK6ja+CSVfBAhgN1TaaFdY3Lw4=;
    b=E8hfghrs3khl8lvj+OJN1Nz191uZiY/upUIvoI18w7ggQ6rNFz7WxofsFwkEjRBYaK
    Y53dT03isezAYufqeKNln1GQhi0+XwF9xDL5G+5y8SBpPDVFejPH3n0S2yONbJHuy9j7
    yHnMs4YwEIAljeopekOJKVlwvrSTcflV8p2zXHFTRK1QF/JxIuhWhETKOr6BL+gBfmd7
    i4rlftRm/Dsis32NhnwhgLL/kx2NU4noKtUO+dr/u3oGf0F/ZZddnbSeQQH1PCxsX/jH
    KL9ufiJ7fYNHOrlqRPZ8Qhrhg7r4SLlZwgN/dBzZ+Ucz6ERKiy6s3heNrdqW3Q5g4qE5
    LR+w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1696338758;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=X/PO7DAkjkJbhT9/ApK6ja+CSVfBAhgN1TaaFdY3Lw4=;
    b=SFp03DEZPU8V3KFIXrk4D6caixj3tnmQSsythj7+TgjbdESTfUXr41WNBuDirktcVh
    xDzNwkwl95B84FOTlOpfo7uaVkOit8WMajc4DKlBNDhWb/AWkiCGrgBYZFpDuHLHQrHR
    g8PuguCm9M8pCYCLceUV9vWgc0d2RvIdU9YrOjI7BflXhxJhUfwkpyKfykrn/aa/iKwd
    Qiz0izb43/15X/OQneN+N2iHwtdxobyHssscACMxQc9NMIWObrWG2e6LsQwBpV2NjVk9
    9ETf7ooQXPXv9QoXWU9krRoqHLCbPE6eeYBJ41cjGduxUF19CHc4KU3QUnlW8PumPJn5
    YQWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1696338758;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=X/PO7DAkjkJbhT9/ApK6ja+CSVfBAhgN1TaaFdY3Lw4=;
    b=Q7oaWgNa1ueQc6RTZE1XhdAmvNmT7zVmbyyrzd4Ql5dLMmaEcmQVxaj7V2BMSxijFY
    TlDX5Gfo/QC4De1XFkCQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1onXMb0WM++sEwsmZtg=="
Received: from [192.168.23.131]
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id j046cdz93DCboUn
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 3 Oct 2023 15:12:37 +0200 (CEST)
Message-ID: <93863dae-d2bf-60ec-976f-26e752cfe5ad@hartkopp.net>
Date:   Tue, 3 Oct 2023 15:12:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] libsocketcan: Add new functions to get/set CAN FD
 bittimings
Content-Language: en-US
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     Thomas Wagner <thwa1@web.de>, mkl@pengutronix.de
Cc:     linux-can@vger.kernel.org
References: <20210618135127.250251-1-thwa1@web.de>
 <789bd57b-75e6-8403-e01c-f6bda10a799d@hartkopp.net>
In-Reply-To: <789bd57b-75e6-8403-e01c-f6bda10a799d@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Marc,

was there also any feedback on this request?

Would it make sense to continue any libsocketcan development on GitHub?

Best regards,
Oliver


On 2023-08-16 19:01, Oliver Hartkopp wrote:
> What happened to this patch?
> 
> I sometimes get requests via PM about CAN FD support for libsocketcan ...
> 
> @mkl: Do you still maintain the git at 
> https://git.pengutronix.de/cgit/tools/libsocketcan ??
> 
> There's also a fork which added some more documentation:
> https://github.com/lalten/libsocketcan
> 
> Best regards,
> Oliver
> 
> On 18.06.21 15:51, Thomas Wagner wrote:
>> This patch adds new functions to get/set bittimings for both can fd 
>> phases,
>> arbitration phase and data phase.
>>
>> It mimics the same behaviour as the ip link tool where can fd bitrates 
>> always
>> have to be set by calling i.e.:
>>
>> ip link set can0 type can bitrate 500000 dbitrate 2000000 fd on
>>
>>
>> Signed-off-by: Thomas Wagner <thwa1@web.de>
>> Tested-by: Thomas Wagner <thwa1@web.de>
>> ---
>>   include/libsocketcan.h |   5 +
>>   src/libsocketcan.c     | 235 ++++++++++++++++++++++++++++++++++++++++-
>>   2 files changed, 235 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/libsocketcan.h b/include/libsocketcan.h
>> index 1603a7b..844104d 100644
>> --- a/include/libsocketcan.h
>> +++ b/include/libsocketcan.h
>> @@ -40,16 +40,21 @@ int can_do_start(const char *name);
>>
>>   int can_set_restart_ms(const char *name, __u32 restart_ms);
>>   int can_set_bittiming(const char *name, struct can_bittiming *bt);
>> +int can_set_fd_bittimings(const char *name, struct can_bittiming *bt, 
>> struct can_bittiming *dbt);
>>   int can_set_ctrlmode(const char *name, struct can_ctrlmode *cm);
>>   int can_set_bitrate(const char *name, __u32 bitrate);
>> +int can_set_fd_bitrates(const char *name, __u32 bitrate, __u32 
>> dbitrate);
>>   int can_set_bitrate_samplepoint(const char *name, __u32 bitrate, 
>> __u32 sample_point);
>> +int can_set_fd_bitrates_samplepoints(const char *name, __u32 bitrate, 
>> __u32 sample_point, __u32 dbitrate, __u32 dsample_point);
>>
>>   int can_get_restart_ms(const char *name, __u32 *restart_ms);
>>   int can_get_bittiming(const char *name, struct can_bittiming *bt);
>> +int can_get_data_bittiming(const char *name, struct can_bittiming *bt);
>>   int can_get_ctrlmode(const char *name, struct can_ctrlmode *cm);
>>   int can_get_state(const char *name, int *state);
>>   int can_get_clock(const char *name, struct can_clock *clock);
>>   int can_get_bittiming_const(const char *name, struct 
>> can_bittiming_const *btc);
>> +int can_get_data_bittiming_const(const char *name, struct 
>> can_bittiming_const *btc);
>>   int can_get_berr_counter(const char *name, struct can_berr_counter 
>> *bc);
>>   int can_get_device_stats(const char *name, struct can_device_stats 
>> *cds);
>>   int can_get_link_stats(const char *name, struct rtnl_link_stats64 
>> *rls);
>> diff --git a/src/libsocketcan.c b/src/libsocketcan.c
>> index 60142cc..e7a334f 100644
>> --- a/src/libsocketcan.c
>> +++ b/src/libsocketcan.c
>> @@ -66,6 +66,8 @@
>>   #define GET_BERR_COUNTER 7
>>   #define GET_XSTATS 8
>>   #define GET_LINK_STATS 9
>> +#define GET_DATA_BITTIMING 10
>> +#define GET_DATA_BITTIMING_CONST 11
>>
>>   struct get_req {
>>       struct nlmsghdr n;
>> @@ -84,6 +86,7 @@ struct req_info {
>>       __u32 restart_ms;
>>       struct can_ctrlmode *ctrlmode;
>>       struct can_bittiming *bittiming;
>> +    struct can_bittiming *dbittiming;
>>   };
>>
>>   /**
>> @@ -486,6 +489,16 @@ static int do_get_nl_link(int fd, __u8 acquire, 
>> const char *name, void *res)
>>                   } else
>>                       fprintf(stderr, "no bittiming data found\n");
>>
>> +                break;
>> +            case GET_DATA_BITTIMING:
>> +                if (can_attr[IFLA_CAN_DATA_BITTIMING]) {
>> +                    memcpy(res,
>> +                           RTA_DATA(can_attr[IFLA_CAN_DATA_BITTIMING]),
>> +                           sizeof(struct can_bittiming));
>> +                    ret = 0;
>> +                } else
>> +                    fprintf(stderr, "no data bittiming data found\n");
>> +
>>                   break;
>>               case GET_CTRLMODE:
>>                   if (can_attr[IFLA_CAN_CTRLMODE]) {
>> @@ -517,6 +530,16 @@ static int do_get_nl_link(int fd, __u8 acquire, 
>> const char *name, void *res)
>>                   } else
>>                       fprintf(stderr, "no bittiming_const data found\n");
>>
>> +                break;
>> +            case GET_DATA_BITTIMING_CONST:
>> +                if (can_attr[IFLA_CAN_DATA_BITTIMING_CONST]) {
>> +                    memcpy(res,
>> +                           
>> RTA_DATA(can_attr[IFLA_CAN_DATA_BITTIMING_CONST]),
>> +                           sizeof(struct can_bittiming_const));
>> +                    ret = 0;
>> +                } else
>> +                    fprintf(stderr, "no data bittiming_const data 
>> found\n");
>> +
>>                   break;
>>               case GET_BERR_COUNTER:
>>                   if (can_attr[IFLA_CAN_BERR_COUNTER]) {
>> @@ -648,6 +671,12 @@ static int do_set_nl_link(int fd, __u8 if_state, 
>> const char *name,
>>                     sizeof(struct can_bittiming));
>>           }
>>
>> +        if (req_info->dbittiming != NULL) {
>> +            addattr_l(&req.n, 1024, IFLA_CAN_DATA_BITTIMING,
>> +                  req_info->dbittiming,
>> +                  sizeof(struct can_bittiming));
>> +        }
>> +
>>           if (req_info->ctrlmode != NULL) {
>>               addattr_l(&req.n, 1024, IFLA_CAN_CTRLMODE,
>>                     req_info->ctrlmode,
>> @@ -878,7 +907,7 @@ int can_set_ctrlmode(const char *name, struct 
>> can_ctrlmode *cm)
>>    * line. e.g. "can0"
>>    * @param bt pointer to a can_bittiming struct
>>    *
>> - * This sets the bittiming of the can device. This is for advantage 
>> usage. In
>> + * This sets the bittiming of the can device. This is for advanced 
>> usage. In
>>    * normal cases you should use can_set_bitrate to simply define the 
>> bitrate and
>>    * let the driver automatically calculate the bittiming. You will 
>> only need this
>>    * function if you wish to define the bittiming in expert mode with 
>> fully
>> @@ -916,6 +945,64 @@ int can_set_bittiming(const char *name, struct 
>> can_bittiming *bt)
>>       return set_link(name, 0, &req_info);
>>   }
>>
>> +/**
>> + * @ingroup extern
>> + * can_set_fd_bittimings - setup the bittimings for can fd.
>> + *
>> + * @param name name of the can fd device. This is the netdev name, as 
>> ifconfig -a shows
>> + * in your system. usually it contains prefix "can" and the numer of 
>> the can
>> + * line. e.g. "can0"
>> + * @param bt pointer to a can_bittiming struct used for arbitration 
>> phase
>> + * @param dbt pointer to a can_bittiming struct used for data phase
>> + *
>> + * By calling this function can fd mode is automatically set.
>> + *
>> + * This sets the bittiming of the can fd device. This is for advanced 
>> usage. In
>> + * normal cases you should use can_set_fd_bitrates to simply define 
>> the bitrate and
>> + * let the driver automatically calculate the bittiming. You will 
>> only need this
>> + * function if you wish to define the bittimings in expert mode with 
>> fully
>> + * manually defined timing values.
>> + * You have to define the bittiming structs yourself. a can_bittiming 
>> struct
>> + * consists of:
>> + *
>> + * @code
>> + * struct can_bittiming {
>> + *    __u32 bitrate;
>> + *    __u32 sample_point;
>> + *    __u32 tq;
>> + *    __u32 prop_seg;
>> + *    __u32 phase_seg1;
>> + *    __u32 phase_seg2;
>> + *    __u32 sjw;
>> + *    __u32 brp;
>> + * }
>> + * @endcode
>> + *
>> + * to define a customized bittiming, you have to define tq, prop_seq,
>> + * phase_seg1, phase_seg2 and sjw. See 
>> http://www.can-cia.org/index.php?id=88
>> + * for more information about bittiming and synchronizations on can bus.
>> + *
>> + * @return 0 if success
>> + * @return -1 if failed
>> + */
>> +
>> +int can_set_fd_bittimings(const char *name, struct can_bittiming *bt, 
>> struct can_bittiming *dbt)
>> +{
>> +    struct can_ctrlmode cm;
>> +    memset(&cm, 0, sizeof(cm));
>> +    cm.mask = CAN_CTRLMODE_FD;
>> +    cm.flags = CAN_CTRLMODE_FD;
>> +
>> +    /* netlink expects both, timings and the fd flag, to always be 
>> set simultaneously */
>> +    struct req_info req_info = {
>> +        .bittiming = bt,
>> +        .dbittiming = dbt,
>> +        .ctrlmode = &cm
>> +    };
>> +
>> +    return set_link(name, 0, &req_info);
>> +}
>> +
>>   /**
>>    * @ingroup extern
>>    * can_set_bitrate - setup the bitrate.
>> @@ -924,7 +1011,7 @@ int can_set_bittiming(const char *name, struct 
>> can_bittiming *bt)
>>    * in your system. usually it contains prefix "can" and the numer of 
>> the can
>>    * line. e.g. "can0"
>>    * @param bitrate bitrate of the can bus
>> - *
>> +
>>    * This is the recommended way to setup the bus bit timing. You only 
>> have to
>>    * give a bitrate value here. The exact bit timing will be calculated
>>    * automatically. To use this function, make sure that 
>> CONFIG_CAN_CALC_BITTIMING
>> @@ -945,6 +1032,43 @@ int can_set_bitrate(const char *name, __u32 
>> bitrate)
>>       return can_set_bittiming(name, &bt);
>>   }
>>
>> +/**
>> + * @ingroup extern
>> + * can_set_fd_bitrates - setup the bitrates for can fd.
>> + *
>> + * @param name name of the can fd device. This is the netdev name, as 
>> ifconfig -a shows
>> + * in your system. usually it contains prefix "can" and the numer of 
>> the can
>> + * line. e.g. "can0"
>> + * @param bitrate bitrate of the can fd bus during arbitration phase
>> + * @param dbitrate bitrate of the can fd bus during data phase
>> + *
>> + * By calling this function can fd mode is automatically set.
>> + *
>> + * This is the recommended way to setup the bus bit timings. You only 
>> have to
>> + * give both bitrate values here. The exact bit timings will be 
>> calculated
>> + * automatically. To use this function, make sure that 
>> CONFIG_CAN_CALC_BITTIMING
>> + * is set to y in your kernel configuration. Bitrate can be a value 
>> between
>> + * 1000(1kbit/s) and 1000000(1000kbit/s) for arbitration phase. For 
>> data phase
>> + * bitrate can be a value between 1000(1kbit/s) and 14049876(1kbit/s).
>> + *
>> + * @return 0 if success
>> + * @return -1 if failed
>> + */
>> +
>> +int can_set_fd_bitrates(const char *name, __u32 bitrate, __u32 dbitrate)
>> +{
>> +    struct can_bittiming bt;
>> +    struct can_bittiming dbt;
>> +
>> +    memset(&bt, 0, sizeof(bt));
>> +    bt.bitrate = bitrate;
>> +
>> +    memset(&dbt, 0, sizeof(dbt));
>> +    dbt.bitrate = dbitrate;
>> +
>> +    return can_set_fd_bittimings(name, &bt, &dbt);
>> +}
>> +
>>   /**
>>    * @ingroup extern
>>    * can_set_bitrate_samplepoint - setup the bitrate.
>> @@ -974,6 +1098,44 @@ int can_set_bitrate_samplepoint(const char 
>> *name, __u32 bitrate,
>>       return can_set_bittiming(name, &bt);
>>   }
>>
>> +/**
>> + * @ingroup extern
>> + * can_set_fd_bitrates_samplepoints - setup the bitrates.
>> + *
>> + * @param name name of the can fd device. This is the netdev name, as 
>> ifconfig -a shows
>> + * in your system. usually it contains prefix "can" and the numer of 
>> the can
>> + * line. e.g. "can0"
>> + * @param bitrate bitrate of the can fd bus during arbitration phase
>> + * @param sample_point sample point value of the can fd bus during 
>> arbitration phase
>> + * @param dbitrate bitrate of the can fd bus during data phase
>> + * @param dsample_point sample point value of the can fd bus during 
>> data phase
>> + *
>> + * By calling this function can fd mode is automatically set.
>> + *
>> + * This one is similar to can_set_fd_bitrates, only you can 
>> additionally set up the
>> + * time points for sampling (sample point) customly instead of using the
>> + * CIA recommended value. sample_point can be a value between 0 and 999.
>> + *
>> + * @return 0 if success
>> + * @return -1 if failed
>> + */
>> +int can_set_fd_bitrates_samplepoints(const char *name, __u32 bitrate,
>> +                __u32 sample_point, __u32 dbitrate, __u32 dsample_point)
>> +{
>> +    struct can_bittiming bt;
>> +    struct can_bittiming dbt;
>> +
>> +    memset(&bt, 0, sizeof(bt));
>> +    bt.bitrate = bitrate;
>> +    bt.sample_point = sample_point;
>> +
>> +    memset(&dbt, 0, sizeof(dbt));
>> +    dbt.bitrate = dbitrate;
>> +    dbt.sample_point = dsample_point;
>> +
>> +    return can_set_fd_bittimings(name, &bt, &dbt);
>> +}
>> +
>>   /**
>>    * @ingroup extern
>>    * can_get_state - get the current state of the device
>> @@ -1040,7 +1202,9 @@ int can_get_restart_ms(const char *name, __u32 
>> *restart_ms)
>>    * line. e.g. "can0"
>>    * @param bt pointer to the bittiming struct.
>>    *
>> - * This one stores the current bittiming configuration.
>> + * This one stores the current bittiming configuration. For can fd it 
>> holds
>> + * the bittiming for the arbitration phase. To get the bittiming for 
>> the data phase
>> + * use can_get_data_bittimings.
>>    *
>>    * Please see can_set_bittiming for more information about bit timing.
>>    *
>> @@ -1052,6 +1216,28 @@ int can_get_bittiming(const char *name, struct 
>> can_bittiming *bt)
>>       return get_link(name, GET_BITTIMING, bt);
>>   }
>>
>> +/**
>> + * @ingroup extern
>> + * can_get_data_bittimings - get the current data phase bittimnig 
>> configuration.
>> + *
>> + * @param name name of the can fd device. This is the netdev name, as 
>> ifconfig -a shows
>> + * in your system. usually it contains prefix "can" and the numer of 
>> the can
>> + * line. e.g. "can0"
>> + * @param bt pointer to the bittiming struct.
>> + *
>> + * This one stores the current data phase bittiming configuration. To 
>> get the bittiming
>> + * for the arbitration phase use can_get_bittiming.
>> + *
>> + * Please see can_set_fd_bittimings for more information about bit 
>> timing.
>> + *
>> + * @return 0 if success
>> + * @return -1 if failed
>> + */
>> +int can_get_data_bittiming(const char *name, struct can_bittiming *bt)
>> +{
>> +    return get_link(name, GET_DATA_BITTIMING, bt);
>> +}
>> +
>>   /**
>>    * @ingroup extern
>>    * can_get_ctrlmode - get the current control mode.
>> @@ -1104,8 +1290,10 @@ int can_get_clock(const char *name, struct 
>> can_clock *clock)
>>    * line. e.g. "can0"
>>    * @param btc pointer to the bittiming constant struct.
>>    *
>> - * This one stores the hardware dependent bittiming constant. The
>> - * can_bittiming_const struct consists:
>> + * This one stores the hardware dependent bittiming constant. For can 
>> fd it holds
>> + * the bittiming constant for the arbitration phase. To get the 
>> bittiming constant
>> + * for the data phase use can_get_data_bittiming_const.The 
>> can_bittiming_const
>> + * struct consists:
>>    *
>>    * @code
>>    * struct can_bittiming_const {
>> @@ -1132,6 +1320,43 @@ int can_get_bittiming_const(const char *name, 
>> struct can_bittiming_const *btc)
>>       return get_link(name, GET_BITTIMING_CONST, btc);
>>   }
>>
>> +/**
>> + * @ingroup extern
>> + * can_get_data_bittiming_const - get the current data phase 
>> bittimnig configuration.
>> + *
>> + * @param name name of the can fd device. This is the netdev name, as 
>> ifconfig -a shows
>> + * in your system. usually it contains prefix "can" and the numer of 
>> the can
>> + * line. e.g. "can0"
>> + * @param btc pointer to the bittiming constant struct.
>> + *
>> + * This one stores the hardware dependent bittiming constant for the 
>> data phase. To get
>> + * the bittiming constant for the arbitration phase use 
>> can_get_bittiming.
>> + * The can_bittiming_const struct consists:
>> + *
>> + * @code
>> + * struct can_bittiming_const {
>> + *    char name[16];
>> + *    __u32 tseg1_min;
>> + *    __u32 tseg1_max;
>> + *    __u32 tseg2_min;
>> + *    __u32 tseg2_max;
>> + *    __u32 sjw_max;
>> + *    __u32 brp_min;
>> + *    __u32 brp_max;
>> + *    __u32 brp_inc;
>> + *    };
>> + * @endcode
>> + *
>> + * The information in this struct is used to calculate the bus bit 
>> timing
>> + * automatically.
>> + *
>> + * @return 0 if success
>> + * @return -1 if failed
>> + */
>> +int can_get_data_bittiming_const(const char *name, struct 
>> can_bittiming_const *btc)
>> +{
>> +    return get_link(name, GET_DATA_BITTIMING_CONST, btc);
>> +}
>>
>>   /**
>>    * @ingroup extern
>> -- 
>> 2.25.1
>>

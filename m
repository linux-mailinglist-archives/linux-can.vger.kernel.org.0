Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C285D5F8819
	for <lists+linux-can@lfdr.de>; Sun,  9 Oct 2022 00:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiJHWMA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 8 Oct 2022 18:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJHWMA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 8 Oct 2022 18:12:00 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80104.outbound.protection.outlook.com [40.107.8.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4B822517
        for <linux-can@vger.kernel.org>; Sat,  8 Oct 2022 15:11:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKu39p9WpWuf6/hMaRAdK2wrXPpHcStKNyrT6en/CaoFHAuw4a9V2mLPkQIt8R8S+SQkGv79BuC7ZYZmp4I7Qet1RlPgz8s8qvYqIyEHbBZoVRNzJpocDGoGM4otRW4e2i6se6EE7oj+Q9ywfc2R2zOp8J7SU97MzIb/hyxAnPnwUslBV2VzuBkDrg7TA1p6YDXhYEpqZYZ1zWOP3ozye5aLAQVX3HY+RNBaDqdGevFVyMKkCmqDeAg+M+WMOeFx4YliFWinEl+7Y+vVBrqPRD4NyhbAz9rLlBcIrUdRliD4IJBUDjmFAmuezKAJmqLfvWgvA1JhglnAJa+jtdh+qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xDX9L0tDH8v6H9kTDHzc5RSWksMnYhi7u+buwBVGWp4=;
 b=Mma+k8I2wQTohA86Qg0QTutvFSk0joatyf8GSrbmco2lQ24ElrWw4xrFPPVBYAazRzJJjIiQ3UccelrdsfkWUtxVB9t1SHZC13wwgZ61TPogGYpIiFFY/NhA24Ie25PDCUIE1PuYb3/XDkUaYhJh1ryMHkN1FpXR4WNowfTfm3B5iYEYfRpwA90V8MuPJE4tUQeXt13V8reFsszCyEWyl/6YaDkVBAgJiyWoVO0k4d4IksdbI5WQf7XEv3xoHNZNKL7RQh/lrG+DxwAReKW6XD7YON4gWwE/Gle4F6UMSBdyBklpTn6qHIoHrlIlzdZOcFRBiIOiSfCDUk2EVktjdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=victronenergy.com; dmarc=pass action=none
 header.from=victronenergy.com; dkim=pass header.d=victronenergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=victronenergy.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDX9L0tDH8v6H9kTDHzc5RSWksMnYhi7u+buwBVGWp4=;
 b=Svdjy5hqpw2gsUC5PYPwaIr52ApjTrzWEOBzeKryjNSX2SXbQcOPPDHKgUK584nToLkCZ1Kr2x55FU0zBK7dWfp6/IRzMeCCAr/qmxNcVYDc7r+Fj2Z/Szw87zky4khVLYENvZMNz+GaQQ+8PRmL8SEykNHXnSglGF44IK0LYUk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=victronenergy.com;
Received: from DB9PR07MB8679.eurprd07.prod.outlook.com (2603:10a6:10:30e::14)
 by PA4PR07MB7518.eurprd07.prod.outlook.com (2603:10a6:102:b8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.16; Sat, 8 Oct
 2022 22:11:50 +0000
Received: from DB9PR07MB8679.eurprd07.prod.outlook.com
 ([fe80::b425:3038:7139:7ae6]) by DB9PR07MB8679.eurprd07.prod.outlook.com
 ([fe80::b425:3038:7139:7ae6%5]) with mapi id 15.20.5723.016; Sat, 8 Oct 2022
 22:11:50 +0000
Message-ID: <6c4445d4-e494-4cbf-3b74-e6db4f37d522@victronenergy.com>
Date:   Sun, 9 Oct 2022 00:11:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 4/6] can: gs_usb: add ability to enable / disable berr
 rerporting
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
References: <20221006162452.200322-1-mkl@pengutronix.de>
 <20221006162452.200322-5-mkl@pengutronix.de>
 <20221006163650.b6n2g44kl5d3ptq4@pengutronix.de>
Content-Language: en-US
From:   Jeroen Hofstee <jhofstee@victronenergy.com>
In-Reply-To: <20221006163650.b6n2g44kl5d3ptq4@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4PR09CA0028.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::16) To DB9PR07MB8679.eurprd07.prod.outlook.com
 (2603:10a6:10:30e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR07MB8679:EE_|PA4PR07MB7518:EE_
X-MS-Office365-Filtering-Correlation-Id: fb37ad93-3345-4d82-e5e3-08daa97a1951
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6G6GIpLn4AekVM752JYozWVhU6Mhb5lkedHXWki77Jv/UT4hT3YOpMnvBb33x1zvOGPGSscDCasYbXRbjmzFEVWJM0qon9VMFhYw3fs5hzrDrztVLPmWZ7dJY4G8OC0xDsZ/SVTB2g8iJ1R1++jj+r92IQpNrONcwH8NNpoyvBo9hsIbcqTmEQSiqBEwvoKPXnpyplxjq+03iwyHSsCecFoCl8xColOAVXaBiBVEX+2pTF2N6icRHPNGCa5EhYfGhY+CxVjR1c5mKBmbhgmMQgtpkgfCqaTXVOlIjUjypBOFgHZLG53IFtNdCjsSpnit3fFaPsT46FnRZa5wmcExbGEGfjg6gQTqgaUJClwvjfTcOyncNJlhFB7ys/DOmDKFnV65iO+dgd5seWSpBmIjPDiIaK7gZsHpvg7TXUwNQCKdGvVHqxkUJg7Lssf+Taeor4nylEU7x5pc40ZSXWfC/t74XwUTHLeQADsejqBQK/GyLJhSZDJcvviFaqo3kWpTge78+/fIPxpejb6JiWf+tyU4i094tm0kLBzbX3FqhoQQktjhUJppkTd9wGRyGNNG++fEPhtEjpK4CCDbvBcGD36125EVD3e6nQfkzTRtMUcj2Aeh3G2MQ9FcV6+XGCDb/LjI4Wy3T6nIVus8jRnIyEsChAkI4H3ZJghv6bKeJfkIe1Kp+qduW78jUAyy13MGSo/zTTpJ0JuotuYsrbMfS+u+3D4vhLfcR+9bC3Gj3TwHGALoFwHBj8Cjjm8+6vXCR6IXKkk8w4m28tAIfiiavBomLgLrncCKgf70gTKr1g0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR07MB8679.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(366004)(39840400004)(396003)(451199015)(6486002)(186003)(83380400001)(31696002)(26005)(6506007)(53546011)(86362001)(6512007)(2616005)(478600001)(8676002)(66946007)(38100700002)(66556008)(66476007)(8936002)(5660300002)(316002)(2906002)(41300700001)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlRFRVBFN2JMUVVUampNTU1jSFlXUHhkT2NhUnlEQkx5bGtQZEQ3UmI2ajJL?=
 =?utf-8?B?T1AwRVF0MHVvbjNFZnNPSnlreTQrQ0IrSHpjR2drbTlEeHZDNUdMK2lkNTE5?=
 =?utf-8?B?dSsrbktXSy9kRmN3TVkxSEs0YnFSTStVamVvRGtIQ3BqbTlCWFVkNlR0Q3RI?=
 =?utf-8?B?YmJoTmFZbHBCNnd2UmVheEdxeXhSNXg2NEFXOXJ6Z3diRXlDek1GWFkxalB5?=
 =?utf-8?B?REFtOXh6UmluSWlMS1V6RHByNnN5VW04cTJzUWdzSnl6VUJPelJLalhpQUM3?=
 =?utf-8?B?Mmt2ang3eW1JbHA0UElHbUtMd1lqTmRGY0pIc0xwMHRCVFg3dldGYmNRbExt?=
 =?utf-8?B?d3N4K2owSEwrODZXN2xyV3VjWG8rdWlSYVlDRjlHaGRLN2hvRXBFUi9jaXJE?=
 =?utf-8?B?dEZIV3hoN1E1eDNhS3JlSlpkZXVRUERPNzRnT2d4YWdwL0UvUG1iWU5XQmZu?=
 =?utf-8?B?VUdOckJRQzZ2bnVtZFNwQ2xhZEhXcTN2Skg2V2FINmhiczNyV0Q4cWM1TVh4?=
 =?utf-8?B?WE56WFd6UU1rNzlYZ1l0QUdwbzhxajNyWVRCTitaQUppaWpnUlRkUXlHQkhT?=
 =?utf-8?B?STRBVkU0b25yV2xEc2FpQ2RIMmw2T2kwL3pDU2pmSGt5ejUrNUs4dDAvd2JD?=
 =?utf-8?B?aGw3RFRVcmM3ZEl0NHRVSW1Jci9YQ2xDQlJLejFFdzZXdTRMWWVDY1RMMmls?=
 =?utf-8?B?MlpGOHRUMGpLRExFeWV3Z052d0xmbFlzRzE2SzVqUUdBeVE0SitxZlhwbUl4?=
 =?utf-8?B?YWNMUm1xeVVXTGdvTFBKSFVmRURTYWR2SVBRK0R4QzlwbW05Z1Q2b3Ywa2VM?=
 =?utf-8?B?TkowMzJ2MlZJWWVEaUl6REl6cjEvTTYzQ1pLYjdtSnJUR0hLQm1meGJ1bUZT?=
 =?utf-8?B?NnR2ajlNb1B6dnRYckFROHN2YWljZkc4UTcrVHBRd1ZhL3l6WHdQSVRac2Z6?=
 =?utf-8?B?Zk40WTROOGlkWW9ZWXEvNnVXSjMzcFhBcVdGQ3RjNEthWENiZTUzU01nWjhB?=
 =?utf-8?B?K1lzY0hsUkVSVzlNWHcwNGo5VmtRVGRqek5HVFBaQmF0SFczaWtyVnhienhh?=
 =?utf-8?B?ZzB1SXl5cXV3dG5KdkVtNHlDNXZKV21ONkY3UGkvWEo5MVZUUzRhRlU5R3By?=
 =?utf-8?B?MXdtMzA5QVlNRVhVekFaOEdkWXFjT1F5WXE1ZHhHYkM3SklKWVF6aWN5ek9S?=
 =?utf-8?B?bHhHOU1MNjNPR1hKV1JwbHRleVRtZWxQL05qV1JpUklObXlIQUtaUkpCV2M4?=
 =?utf-8?B?bjBXei9pdUswczBudGVUM1c2L3VEbnRkenNDZDd0VkUyZVFiak1QNUNsdnJz?=
 =?utf-8?B?ci9GVkk3K0ZIRktqV0wvOVVVVGg2cEJmM3kvVHhnc3VEeUhuM2NGM2VtNWxa?=
 =?utf-8?B?U2ZZd2twZ3NXc0pocWJzZ05RY2V1WTJYV2ZiYzJxREIzS1ZiN3htTEpGRnVh?=
 =?utf-8?B?UjlQN25UdjdMbXR3T2pXdFJPUTd4STJTdUo4aVBybTczSGJtVUR2NXVxTlND?=
 =?utf-8?B?dEltTGFnTkZqUk05cHE2bTNiOUIveGtLYkQvaWN3N29BL1p3U1UrcDd6U3pp?=
 =?utf-8?B?UmlUZ0E4NnVFNW1zeERUYVgva3BrUHZHMnpmRUNXU2Z5dVMzbzdZRmJRZCtD?=
 =?utf-8?B?Q2k3MGt1bUtHMDFwbTdrTXdORVV3Sm5ib2c1V0FGbVM2MDljV3pWR2JJMjcx?=
 =?utf-8?B?MjZXVUZ2U1UyTnhCVDAxMWVjd0Zub2xsUEFHRDdBc2FuQnRvRHM0S3ZCdVVr?=
 =?utf-8?B?Q3FLMmt4Y0J4QitKYjJjcHVxREpGK1dqWS90eGZiMW8rNUZiaHdnN2FySWxD?=
 =?utf-8?B?YlMrRU9idk1vWUlBNTBmcU1tUUdHdElib2hQVVRGcWlKTjVSSm1NRkJRUEY3?=
 =?utf-8?B?a0wySU5GaWlCeFIvRUdSSlFRUnhldlJWbmZzRlg5MU55b09WbzdKRlcrOExk?=
 =?utf-8?B?aEFuUjZGN2hvNkxzTFFPVUZyUVIweUxybFc0V1pRYjVUbXE1eFFZbis0WVFC?=
 =?utf-8?B?d1Jqa2lYa25yaDdYeG43eCtDY1RzSG1paXhOL0YrZ1B2bDlIVjJGN1NkL2wx?=
 =?utf-8?B?M21OVWhKOHBFK3dPQmFBSTNHbW1icVlhNVBWcS9oaERjRTZTVUFvZENUQVgz?=
 =?utf-8?B?VjBzZHhmU1hvU2lxQTFIaTQrMFhPMkgrNkJQSVM5bW1uMCtaejZUaVVqSThj?=
 =?utf-8?B?cWc9PQ==?=
X-OriginatorOrg: victronenergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb37ad93-3345-4d82-e5e3-08daa97a1951
X-MS-Exchange-CrossTenant-AuthSource: DB9PR07MB8679.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2022 22:11:50.3342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 60b95f08-3558-4e94-b0f8-d690c498e225
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gkH9U4NsDB39X3YaI1B0zbVQ++24QCp/pD0/pcU4S/havCbD8XU80kXs3oVH0gJNMGYc9i6pSImqbYcWGQP7Ffi5SyzBTPrllvvaWoBAkdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7518
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

On 10/6/22 18:36, Marc Kleine-Budde wrote:
> On 06.10.2022 18:24:50, Marc Kleine-Budde wrote:
>> From: Jeroen Hofstee <jhofstee@victronenergy.com>
>>
>> The open source firmware candleLight report bus errors
>> unconditionally. This adds support to enable / disable bus error
>> reporting with the standard netlink property.
> I haven't checked the candleLight firmware, yet.
>
> If the unmodified firmware sends bus errors per default and we introduce
> BERR_REPORTING as suggested in this patch, we have to modify the default
> behavior for bus errors: By default the firmware will not send bus
> errors, but only if GS_CAN_MODE_BERR_REPORTING is requested during
> open().
>
> I'm not sure if we want to change the default behavior of the
> firmware....To work around this backwards compatibility issue we can
> explicitly turn BERR reporting on or off during open via
> GS_CAN_MODE_BERR_REPORTING_ON or GS_CAN_MODE_BERR_REPORTING_OFF.

It would look like this, untested:

subject: can: gs_usb: add ability to enable / disable berr rerporting

The open source firmware candleLight report bus errors
unconditionally. This adds support to enable / disable bus error
reporting with the standard netlink property.

Signed-off-by: Jeroen Hofstee <jeroen@myspectrum.nl>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
  drivers/net/can/usb/gs_usb.c | 18 +++++++++++++++++-
  1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 7c1f13a90419..039e8d91ad88 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -135,6 +135,13 @@ struct gs_device_config {
  /* GS_CAN_FEATURE_BT_CONST_EXT BIT(10) */
  /* GS_CAN_FEATURE_TERMINATION BIT(11) */

+/* Previous versions of this driver didn't support the berr-reporting flag,
+ * this flag tells if berr-reporting is supported. When not set, the device
+ * can default to its own preference to be backwards compatible.
+ */
+#define GS_CAN_MODE_BERR_REPORTING_SET BIT(12)
+#define GS_CAN_MODE_BERR_REPORTING BIT(13)
+
  struct gs_device_mode {
      __le32 mode;
      __le32 flags;
@@ -174,7 +181,9 @@ struct gs_device_termination_state {
  #define GS_CAN_FEATURE_REQ_USB_QUIRK_LPC546XX BIT(9)
  #define GS_CAN_FEATURE_BT_CONST_EXT BIT(10)
  #define GS_CAN_FEATURE_TERMINATION BIT(11)
-#define GS_CAN_FEATURE_MASK GENMASK(11, 0)
+/* #define GS_CAN_FEATURE_BERR_REPORTING BIT_SET(12) */
+#define GS_CAN_FEATURE_BERR_REPORTING BIT(13)
+#define GS_CAN_FEATURE_MASK GENMASK(13, 0)

  /* internal quirks - keep in GS_CAN_FEATURE space for now */

@@ -919,6 +928,10 @@ static int gs_can_open(struct net_device *netdev)
      if (ctrlmode & CAN_CTRLMODE_ONE_SHOT)
          flags |= GS_CAN_MODE_ONE_SHOT;

+    flags |= GS_CAN_MODE_BERR_REPORTING_SET;
+    if (ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
+        flags |= GS_CAN_MODE_BERR_REPORTING;
+
      if (ctrlmode & CAN_CTRLMODE_FD)
          flags |= GS_CAN_MODE_FD;

@@ -1223,6 +1236,9 @@ static struct gs_can *gs_make_candev(unsigned int 
channel,
          }
      }

+    if (feature & GS_CAN_FEATURE_BERR_REPORTING)
+        dev->can.ctrlmode_supported |= CAN_CTRLMODE_BERR_REPORTING;
+
      /* The CANtact Pro from LinkLayer Labs is based on the
       * LPC54616 µC, which is affected by the NXP LPC USB transfer
       * erratum. However, the current firmware (version 2) doesn't
-- 
2.25.1


That claims another bit, but at least prevents the !NOT_BIT_ERRORS road.

Well, as far as I am concerned it is up to you guys. As long as there is 
a way
to suppress them I would be happy. With stats + counters you generally know
more then enough, no reason to flood the bus with useless error messages.

Regards,
Jeroen



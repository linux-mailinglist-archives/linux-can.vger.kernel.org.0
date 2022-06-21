Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379D4552AB2
	for <lists+linux-can@lfdr.de>; Tue, 21 Jun 2022 08:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiFUGCP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 21 Jun 2022 02:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbiFUGCN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 21 Jun 2022 02:02:13 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2118.outbound.protection.outlook.com [40.107.20.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F84222A4
        for <linux-can@vger.kernel.org>; Mon, 20 Jun 2022 23:02:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oF2WpzXxfRivogD7CmsHvJWZq5b+QlaTJu8tdZU1r847vXgW+PDko0dSNVXt8YXchO1h0wpdMFRGoG8A+iVotVHRI9irClPaF2QwKO/NcVJrwkPUUBJ3rdjFaIWxVhst1XnAnp04ZxQu1CjaQAzClFxHqKva9TJ+FSRSDp2WR3zFoMEpfc5hkPvxQsEYgl1+1O03LgS9AK3V7YeoU+aA8d9HLjqe8fN1M/PsiMzdrtBQrhxzc1PEYNIrFRPmGvfg/ecM6TnXdtVyCHANQu35Yf072L7Vk7LdR1BVOkORQICj6N8muJyIEh6gefo6e81kl3vAeM7oNJSLJYFJPIpU+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6dFVT0sAljD0Xe7RvlqBTY1f0eOltsYiVy0TYXc1OkY=;
 b=hkqAEen1d+l4Q3PI011sfX17Npz7U89sIs0wCAkxqbPtYEAtVv6REmk3DFWTor9+7DUEbQbHPMxpLthlXjtdhKNr3qqWPioQhunFNys27G3/ipcabAQ3Nt1fQMuyV3V+kGfQi7sZagAqrneex2bXDWF7/nY15uY4chUzyddyv13OYAaE2u7K0aOuZ6rNMTJkJBLkvhsSyviItPA9rPCjFhqad8FBVobI/+kEZi4XZ4ELDY5I9QFNuYik1UypCLhNKh5k/7UMLcB1f4LX0F7FdwR1bcB4VM/R9Z9IAakbN3FbQjW3Nd02wliMjsjaM3ykW+Obp44XOrz6fiVZDovQMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dFVT0sAljD0Xe7RvlqBTY1f0eOltsYiVy0TYXc1OkY=;
 b=WX/0Y7fAZ0t2DCpVPYWzEPXLsFGJN8gET0RECeoHxUl5GV1SssJPLmerH1vqgxaqVUO3UrI+hnOZqUkYPBtkIz5rj5UvR4eKMyMdNE+86lgQEVt17AgaGrsN/2AF9NcnW8Vw0v90a9CfRKysC13Ljw7VGPAEHt65Bmww7pEobyo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34a::22)
 by VI1PR10MB3117.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:e3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 06:02:06 +0000
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2827:221:b57a:e8c8]) by DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2827:221:b57a:e8c8%6]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 06:02:06 +0000
Message-ID: <557fbf95-a361-be0a-3e8f-42fa1365c9db@prevas.dk>
Date:   Tue, 21 Jun 2022 08:02:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] can: mcp251xfd: mcp251xfd_register_get_dev_id(): fix
 endianness conversion
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>
References: <20220620144954.895582-1-mkl@pengutronix.de>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20220620144954.895582-1-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0031.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::22) To DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:34a::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43c58dc4-e19a-4a4f-4d5a-08da534b91c8
X-MS-TrafficTypeDiagnostic: VI1PR10MB3117:EE_
X-Microsoft-Antispam-PRVS: <VI1PR10MB31176B21C634B5126294D70593B39@VI1PR10MB3117.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nrhr5vUwoumhDtPHXoT8ML/wCZP6S1jnRtFoieP5TxEZDpR/dXwvmHVUItJIP4fYQn+lGVS8rzky1w8jrsc3AHrT8lowBvccq59B6pHjdUwQHgy7wp2rgmDV9vSIc3x4ef+qcKgv+XTWHeL18tfclp5uyTmnMXc2IaL4ZOwr9TdbHF2sXoSe2egWqXpInQlv0awmlCg1zFF+43hDmU8HCFr/F3rNYv9MDXoHK+imnkZQgi9ohrKwO/RUE2RHHA9rOGQY9jqzyoUeMEXYrnvW5QYz7ym/wT+dB2LZF+1MJSRxduxbCc7Nn6oQJ1madBQDxzoQiX4r1VNarGRF8osDfLiZwjUygZaOEPp9YkdtJq+mmvaPZPrRjnbD/UsO931Xc/ESc3TxtcsqxrL/IxwWj7SybwUPUUyz9F6U7kO0ZrJXtpXs2Qx2kwsgYNgaK3rw+QZfAlUn49c65MccHeBoJiQnVqQ+NuS9KdCAiqycYLEx067gqQAALa0tx2AeVXbN4RjDrM3VUeT1yYrhZAe4H0pfaCKOvYwRysaPnOB6YB7YZj3QtyKeWTiTIBsD1oVW4oreOxqrv7q50LsCgCpqW337pgsoRk2yR9XjiWmyUqN0lZp3PxpXUnUTUKS9h1/rLcw7zt+FTyAeZkXwiEHnJqaj2hUi49BSkfVLVu4Mnibwb/OQuf078WD2uCI2c7xL5RbccO7Z310TjYoCHOZpFSB3lSOax4Z6EVrrzquizkDMyYiUV1JiALoim6LwMpz7+3TYHIHK8K7WibcdE2PDVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(39850400004)(136003)(366004)(346002)(6512007)(2906002)(26005)(38100700002)(38350700002)(6666004)(6506007)(186003)(52116002)(2616005)(66946007)(66476007)(8936002)(6486002)(31696002)(5660300002)(478600001)(66556008)(8976002)(8676002)(4326008)(86362001)(31686004)(316002)(36756003)(44832011)(54906003)(4744005)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTVkdW0yalhGZzI4SVY4cWxJV0FXakJtcDZKQnJVYmFjVzFuV1BwMEROSFdv?=
 =?utf-8?B?RzFNdWJsQ0JnQ0FDTEdhSVJtWmFCYXpKWFp4WXRxM2hTZHdSdjNSUSs2a0pN?=
 =?utf-8?B?LzQwdDRuWHlFZEFOeFVVNFFZM3Z2dm5ONGJudkVPTmpPY1IzWFQxM1JwSEZt?=
 =?utf-8?B?b3hxMFRhSjhneHp3emtZd0JOMzI3SEFRTmlTQmxLbGN5WDEwdU5uRWRPVmd6?=
 =?utf-8?B?dW10eDR6NVpYcTA3anRGZjl5Z1EvNjhCeWFETTA3MjdTOWUzMm5ZeC9YWCs1?=
 =?utf-8?B?TWlaRVF2ZFVzS3ZpUjhLd2J3a1VlaU5UdGZGQjkvUkI1c00vYjBJSy9WK2cw?=
 =?utf-8?B?a0N2ZHR3MTlqR3dCaGZ3aVByY2JmV2J4dUFqV0FnclNacGlRTlc5WVIxSDRL?=
 =?utf-8?B?QVJpVFpKdkd2SnZqV25ubkFQUDcybS9DTm8wY0FKbXFFRmVySDBlcnhqQ1Vo?=
 =?utf-8?B?WC9GcVFYYThrY2pYSWVVS3ZhNVNhZGlwZHJRc3JOUlZhQVpUckhLeDNXRSta?=
 =?utf-8?B?TVZmemlUdXJBSW54dDVDNnhpeklXSlkzdjdzb1dlS29adnI5M2tHZDU4Qzkv?=
 =?utf-8?B?dmRkcEhzYVRjL0pva2liMCtzZzVPUmhPMWM3UklYMFdKc2tMNlZnQTd5akE0?=
 =?utf-8?B?Rzc3OEdQU29uOEZSbjNJRHVEL2Z2dGxMN0pwbzAwT1MrMk5kT3l4TzAyS2Iz?=
 =?utf-8?B?NnZPWHJDMm10dDNGL2FpcnBYZTJQNWZQSXY5VThLUGJhejJxQlRqUzgwM0Jy?=
 =?utf-8?B?Z2NoZ3NqaGtHaElSazBwWlRDdTJSakxXZXorbUFLTlo0K1pBMktlY043c1BZ?=
 =?utf-8?B?dURBVmNMREhYb09JSldCQTdvYjlQbzBydW41bTFSYUQxQ3JBTnJBVVdwbTdt?=
 =?utf-8?B?K1puOVJIUndsQWNVbG5mU1NnMjgxVVZRcnFYek5JZ2hIQ1k0M1VnVVpKZE9M?=
 =?utf-8?B?SVNwSy9heTI4WFo2MnViNEtQdWEwbnJuZmdHMElMcHl1Sk5UcHVIWnRjWXRz?=
 =?utf-8?B?eVc3cWUwZ2RGYmgrTlppK21xdVIxWFROaHpQN2kzWmY5VzluRHA1NzVkbnBK?=
 =?utf-8?B?aHdJcXpjdE90NzN5Sk5Nb01JaElrUFRENkxvUzQ4cDkrSVR0TlhhNDNyMEV5?=
 =?utf-8?B?eE4zdVoxWmZGekRqM1JFTzFiY283OVMwYjlEanBtanc1d0RBZHVZNktMRVRi?=
 =?utf-8?B?STVrSlpnNTdlOXZKTENPclJuOVBRaE9vaWtJUWNFOStzT0lITncvaHRHSW9w?=
 =?utf-8?B?Tk1kam9NUm1iejZoa2kwWEdudG1YWGdTb0loNVRaRlRIdGFySmE5T2toSHJ4?=
 =?utf-8?B?MFhpOGlyWUhQRXp1NmZOUXpsdzY4dWhxZFFTc0lNRTN6ZUVOTi9aclNKbFE2?=
 =?utf-8?B?bFQrbXJIa2R6Q1JXdk1POU50djVzcFgzOXYxLzRNN2FPSzlXQ1FRdDZoTE42?=
 =?utf-8?B?bDQ3V2p0MDc1bjNPcXFiSzZ1ZnhTWmNDcEFJNmhYYVZ6UFN2emt6ZEQxNUFi?=
 =?utf-8?B?eGtlMjlYQVhVLzJKRE5WUVowWGQ3RDZIQlRhQUptT2ExcFhuQ0QzT2NlUFo2?=
 =?utf-8?B?TVRyRXZ6M1R6ZmRyeEtZQW4zK00xN3Q4WU5Cc2V5Uk5HdjRIYTRwaEN6aHk2?=
 =?utf-8?B?WVVZMTF0M3puQTdSUGlTWWp6ckplWTJXVW1CK1R1dnpvS3NvS043V2o2OFBl?=
 =?utf-8?B?ejJGK2czK1lkTmdyUGlsWDBvTlJ2TkhHWDZqLzVUaWdSSTFyZmRoNVZ4L0Ru?=
 =?utf-8?B?VVBaMzArYWtyY0lkRFlmVFlNU2dyaTJVUElHczZyd1EwRW5CR0c2ZmFhOWNk?=
 =?utf-8?B?OVZiK3lRSW9SUjgrdkc1cElYWDJra3l2dkpUNDIyVzN2RmtJVFpNVEtiVk9h?=
 =?utf-8?B?SVZZUGQrRWNmR2MwTFozY0NaNlpRMlNjN2tzeldUOWNvNVpwalA3M1pnbDV4?=
 =?utf-8?B?QlpHMnZMaDA2NUI2dGxTMzVoS2ZxZUtxWDl3eEhMVEpiYi94WVR5eW91TWVX?=
 =?utf-8?B?VWpoN2VEOFUvVnRrdmNJK3BZTS96Nkc3bXoybUsxK1pUcDJsTFR5bFl4LzNL?=
 =?utf-8?B?YUlyM0lXcFRnL2ZsTEdIdjNNWGppNkZoQTJtczA5LzVMZHpMQ2UwNE1IOHU2?=
 =?utf-8?B?M2EzekVYMUhhMGtKblR5bGNzYWYzUGQxTGxrRjB1MmxOUDBXVUtWdkVmd0dl?=
 =?utf-8?B?WDhVNU90VTQ4WTdieFZyQmxnZ1NUZ3FLeDJLNkxUOXA0eUxsY3lzVThRQUhH?=
 =?utf-8?B?V2tjNUM3eSs3Tm5TT1Vpa0lVNGhia0FUWHJkWkJzL0o0ZmFYL0pMcjFESGIx?=
 =?utf-8?B?YlBwcWM4dmdCRGdvbkwyQzFuYVplWXZVVzI5cENNSWNGcTNSUzRCa1l1cVpR?=
 =?utf-8?Q?i/XzcH921/av6FVw=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c58dc4-e19a-4a4f-4d5a-08da534b91c8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 06:02:06.2165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EKH95TWvdkHMKG82IGfoxKJxGt8pnnTEhtzjE+v8/oHiazgZjThBFXKnNyo80/rjD5cO9Hshq/X2Kc8CRwk0tcGjaxE3ikr6z9q3BAKKc8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3117
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 20/06/2022 16.49, Marc Kleine-Budde wrote:
> In mcp251xfd_register_get_dev_id() the device ID register is read with
> handcrafted SPI transfers. As all registers, this register is in
> little endian, too. However after the transfer the register content is
> converted from big endian to CPU endianness.
> 
> Fix the conversion by converting from little endian to CPU endianness.
> 
> Side note: So far the register content is 0x0 on all mcp251xfd
> compatible chips, and is only used for an informative printk.

Reviewed-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

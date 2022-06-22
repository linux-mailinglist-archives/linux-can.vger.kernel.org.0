Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6445C554664
	for <lists+linux-can@lfdr.de>; Wed, 22 Jun 2022 14:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353288AbiFVLL0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 22 Jun 2022 07:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350021AbiFVLLZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 22 Jun 2022 07:11:25 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140047.outbound.protection.outlook.com [40.107.14.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8733BFB5;
        Wed, 22 Jun 2022 04:11:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dEhyluAWa0w1ahk1P1JkQQ8ovTVY9ykpNzXuMiQ3VOSo1Yvt5Yk//OTUbk+8m3JSKiaLgbbSbHwHG8+7hMmvjkJ+rzSic+oocTjQ4IpPuF1CudaCeeWMbEhURiplERxKmVIrcguJFmCo6FiHPMwtpY2SwP7H8DQCTlVbiT6BGw2x2yi7Dg8zEXtpV/fG2/+/hwHJMmnWSU6++3qufkA9ADIX5cvmFGug07fAD7t/gP+4y9jbCQpjdslVaQkT5un3SIWxbxwKCyT6vIlIENO804uUnvdL0D1PpnbhpVOE38PuhkVtdwe6bRN+0tp5jIKfVMZ+D3ESyC8N7ddtzBp3jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6CGnT5/OoDIMno4J9oXcV4vqsrKcMsPWz2dqDUzCrA=;
 b=K2OF3r6w4RbZWvpkrDDaFiEZCVTGRc8V1WnSieHba7iKZq6ZRg4P/Glieq8fVoJcWI9HOVeUg7ufV0WQZ/gNzvLm+KsdJrFBjvtO1jB+C6cNzS3QN767AVdIAJQ+1jCNLmprJNj/ppHKmcm5J2TZCW/TBl7AR8F1rpgv0VRW+A1Ji67+NTo6OVLybpe0JA72gPml1pKerqfPjVwenVD79eC0YXomhRsaF57tLKYeb7vO+oNCfDAJdG7cA2+ASoeqI+hfWo3SNYUWekSV33EMSaDIB/lzwB//cEFPDe/irxqd2j//qNgwt2inc5PmVKdMnzIFOoOy1mnrQXyBx+2daQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6CGnT5/OoDIMno4J9oXcV4vqsrKcMsPWz2dqDUzCrA=;
 b=fPKLCYQDRrateEa4Kp+hWXTELrj15nLROPWceFatOe3cnezaXeI4f0cjVAgW4isiy542zfx5ExwzXUwp6vZuAjGYoPUQjek3aRmcTM5FVgDyDymz6oT3y/iNQ6dRYXVpYLz/lwS76LOUI3yOYhHiBaUjjfYQnL8OxaY+DPwn+k9OU0Ne4ExSF3vxYt8EgLh69T9BbjHJw4xjpDovwNBdRPqdMv+CcC1BGCmluNxKGS1wBX7U4Nr7lzZVVWTTxWrShgvrtkjSDqOQtji0lHMuuaa5o5kGfGY7UuBnTH8oh9MYC6s+GW8KvEJc88oI/eE3FdsbM/cgVGNMyETsi6NnAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16) by AM0PR04MB6788.eurprd04.prod.outlook.com
 (2603:10a6:208:18e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Wed, 22 Jun
 2022 11:11:21 +0000
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::21d5:a855:6e65:cf5d]) by VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::21d5:a855:6e65:cf5d%12]) with mapi id 15.20.5353.022; Wed, 22 Jun
 2022 11:11:21 +0000
Message-ID: <cf10d129-2454-dbc1-e6b0-f7b562f77e49@suse.com>
Date:   Wed, 22 Jun 2022 13:11:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 1/2] drivers: usb/core/urb: Add URB_FREE_COHERENT
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc:     'Vincent MAILHOL' <mailhol.vincent@wanadoo.fr>,
        Alan Stern <stern@rowland.harvard.edu>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rhett Aultman <rhett.aultman@samsara.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        linux-can <linux-can@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>
References: <20220610213335.3077375-1-rhett.aultman@samsara.com>
 <20220610213335.3077375-2-rhett.aultman@samsara.com>
 <20220611153104.sksoxn4dmo5rgnk3@pengutronix.de>
 <CAMZ6RqJvU=kvkucq0JiKgTVxTBJveCe47U-UCguKTdpLvh7kHw@mail.gmail.com>
 <YrHM8mqG3WVVesk4@kroah.com>
 <CAMZ6RqLVu-kPy-EAy52a5VvRmv=9RUTC2nw0gwQUgg_rTgiB5A@mail.gmail.com>
 <YrHfuVF4bPXzihEZ@rowland.harvard.edu>
 <CAMZ6RqL42DKD3evR4skswaJnAwOAO_qrZgXoLax7O95xVKUomQ@mail.gmail.com>
 <48caa879b0064ced97623bf1dad5b2d9@AcuMS.aculab.com>
 <YrLjsAOlsizMc/1c@kroah.com>
 <186561fa929f459985ad2986936988e5@AcuMS.aculab.com>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <186561fa929f459985ad2986936988e5@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0545.eurprd06.prod.outlook.com
 (2603:10a6:20b:485::15) To VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5cb4d597-26cc-4873-deb9-08da543fefbf
X-MS-TrafficTypeDiagnostic: AM0PR04MB6788:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-Microsoft-Antispam-PRVS: <AM0PR04MB678892F27AD789700CDED5FBC7B29@AM0PR04MB6788.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4v0mjQd+cFago+7ZZ7VSR1Aji+zhS7wbvfG4RDLwGTUP2/CEieu4+e5EcSiEoVz3vAiudcrmOolLUHhS4wurTg1tL5xK3cZvr5CX6e14s7Qwr1HBSBlxVBctlNMPRKfFJy77LxDBBviKpYv12wg3uzu98MXh83rYd1VTzS1YIbL4ioQRS0h84Kd/KzDRnNbc2Lk08HE9zsyYIyZSO+phweXbrG2V4/vNpKVHFKJu8EHRxW7esLM0d8MekuavV7o7QW7Ck1VD/+frUNNlTIL0doWCD4F5zsl6Nso0pIuNdW1NYaMgNXm6w/3gWPCRYNnq2DxcY6N6e/eXEcEmYi99bAcYj9AI6IvCeyNfztY9j7iKFsrSA30zrJcyUWiiZB+DkXh8Jg5u+pP/wDuKcfn+OC6EqZwuAEIRhm1VvuLzo6ZfwQYy3mmzNGrc6kF7JUob/IS9YKXrBblF4DfZ3YoYsgXjvMpTb7qnolbDBijzmiaGy/1RbATwp2AMgGPjDFrNSrzvULemmEyzhf/BBG3FVzFMn7I0nli+zVy6flpobfU3PTo8DV0VfBj9DE/4tpdzUVOm7U2ibXHjbQSugZg9V43KrZIUImEITd/JbJR1htWO1h0DPTZeftLDJj2tXV+wm75x6e45bSo0C0zdvPIhjjLDhnM+QiKCjP6Q2mqtDU3goVblIINJ5mCbiBRDGJUQcEDNkYzmqwM5Y7aJtSNpe5xLQ3iZINGlwT+2PR5FAS+4OLB0tolbXejdgNiFYJruBtcmy5MF3tgCzQ8plMq3tsZpfNwptUfR66gJkhww648=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2526.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(396003)(346002)(376002)(39860400002)(6512007)(31686004)(36756003)(316002)(6506007)(53546011)(31696002)(38100700002)(54906003)(110136005)(8676002)(86362001)(41300700001)(6666004)(8936002)(5660300002)(107886003)(478600001)(66556008)(66946007)(66476007)(4326008)(4744005)(2616005)(2906002)(186003)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkxKc1BVS1B6TjA1dzBVVXNLaVRDcDJaOFdHTFlJdFJod3VYKzJtM3dnUE9N?=
 =?utf-8?B?UjRyc3pnWXp1bldiVHR3VUpRa01DL0ZkL0dFZnUwVzVkcWlLTTNUTkcyVE1U?=
 =?utf-8?B?ZVhranBKTUNNcmRDYXFZcjd3eE5pR09OSFVXVVc5YmlEYWJNT25peDZvS1Vj?=
 =?utf-8?B?ajZCLzh2RDB1RGVHNEZFejB2QVVZdFdmSmtrMk95cmNoTlNKc1FJRU1EM2gw?=
 =?utf-8?B?OFRzc1FmRnpOdUVHemdaMVZBdWtUOERqUzdpZHRCVFUvOHZLeXhYK1ZLeDV5?=
 =?utf-8?B?N0NEaW5nYkRaZFk3TlZqZlJjM3dKUy84cUs0elVkUkw2MXhOc3BvcDI5SU1Y?=
 =?utf-8?B?NDJhVnZ1V0wyanJVOWlpdHJIUjc5MTNsSUlqbEw3cnVyK3AyN3J4T1ZTUmxn?=
 =?utf-8?B?bElOZHNxcjE0RjNVNVFkbXlYWG1DbGxwbXdCZE50V3UxYUlINWd0SHBpTTFj?=
 =?utf-8?B?aW03VWQxVTBuZzZ6TTRNZTJrWDZUUkljYWZaN2RvK0RST1JkQzRKZHFmUHA0?=
 =?utf-8?B?M0VkbXhObUxlYnc0RE53cktIQVorSDdMOWFBTmRuMU8wN2UzSld0dmpVNGxm?=
 =?utf-8?B?dXY0UitKU2xlUHVBVU40MUV4d09HUCtWd0FWRVhQZ044eDRpSVVsNVJhdFg0?=
 =?utf-8?B?TGxUUnJYclFFL3JISVowQWVSYW8rb0hDNXRyaENieTFCQWFqdzFLR3JiMlVE?=
 =?utf-8?B?NDd3a1d3bmZWRTN2RXJsS0IvUHM2YWlKWlFxWCsvMEtheGtGdEJjVEl1UXVx?=
 =?utf-8?B?UjFyMXgyRFVJbE1TWVlETW5SaUhiRVNJT21HMm55c1dvMHZaRDNRL21xa0gv?=
 =?utf-8?B?UGZ4d1NsTVZlRXlQZGd2bTNXZCtJRnVzbFhHakp1SjUzU3BJaWFqNG9aaURY?=
 =?utf-8?B?ZmlEUUUzOWkwSjNQemt4ZFZhbVZ4VkxEdWtDTmxKdEx1dHFoTVBnRU1uenhp?=
 =?utf-8?B?NHg5cEQzcENQNWZPUVhKc0FvL3ZNbjBFc29JSmNrNVJuZEwvK3VMMTg1V2VG?=
 =?utf-8?B?VWVQemsvQXUyU3cvdU1SWG52VWdnenRpSEpNTXBuSVlMbnd6QjMvd21GQitO?=
 =?utf-8?B?UUhTRDFRVlRuTDlXMUZCSnpXcmVlVEc0VndiMEZnNlVCaTVpQWRNWHYvV0dk?=
 =?utf-8?B?Vlo2NTI3RE9HNUNJWDNBa244cjFNbEFJdld5eTl0WXJENk1qZUZQRDBacWNm?=
 =?utf-8?B?enNmbFlqNkF3Y3JpT0R0VWVIOFZZeU1FMUFPVDVGbDRVUkk3c2pTRW81K3Uw?=
 =?utf-8?B?RklPbnlEUjRLVHpUc1VwZlJzb3M2U2FEcFh3K0JhK2RoOUpYOTYwTTcxQ0cy?=
 =?utf-8?B?V25iQTd1WGt2ZlNyM04rZTdWV0VVR1hCZ1ZiSWNxYkRFVm5oSndBSlJjekNh?=
 =?utf-8?B?bWdmcmJscWptTTFKU0orMGNqQWZSUE1xWGk3QjRXN1lqV0dQaExmM2tlQXh5?=
 =?utf-8?B?bnVNTFFJam5ONGczZTRBakU1YmtzVzk4aS9BZGxBQXJGbFBFbmJzZWJFeXov?=
 =?utf-8?B?elQvaDBtV3NEOXRzZHF0NjJ5YWJnb2wzOStrTmQ5bzB4SWhnSUtEdVNTYmNi?=
 =?utf-8?B?ZEZTSk8xaThmMENiMG1Wb0hBcytWb3J5OXA4NGhwWFJXV0p0NlM4YnNPZWFP?=
 =?utf-8?B?YkJTYTdING1uUE1sc1RzczZobytETXE0R3BDNmRWSlZMVXR3eWxRLy9oSEI1?=
 =?utf-8?B?MVJncDdENVBlQXo0eFBTckhxUmw2QWUzNXZZN0RITDVPVGs2RzB3QXVlbytw?=
 =?utf-8?B?T1o4cTU4NUp1YWsvbU5HTDJvT0tJdm9tYkIxMC9FdjdDUlNId0hwRVVmcHpv?=
 =?utf-8?B?bzNrN3UwZ29tU0E5MjZ0ME1XRGFDRmtqRE5rUlJtMDBsQzVaWEMxNzhUbUdw?=
 =?utf-8?B?MnBCcFdCeEVscmxTQ29RNGVuQitqejROQ3lDT2RoNWhIZThtQUxQYVZ5eis4?=
 =?utf-8?B?emlqNlBSMVNtRXlZTE9PR2ZZc0VFUHk5MitWSHdYdW1kQ2FhaGphMmxPQlpS?=
 =?utf-8?B?bVc0azBuK0VxU3VHUXdzRTFNaVlLSG5ITjdsTCt0bktyWE1BVW1YUWpXSHpD?=
 =?utf-8?B?U0J0eGZrWitSdDBHaHh6U3pzRzdnVFdrdlBaYTlXQ0tMRHBIYm9jb2JReEd2?=
 =?utf-8?B?VWE3bS81MEFac3p1aTNqYk95Wm5KN21Fc0VWU2RBMWlSekw5amRVbVY3QlZm?=
 =?utf-8?B?RkVTOElFRlAxanZjLzV2cGpTd0lPektiOUdFTGJYam5VK1NPMlIrWGUvV1J3?=
 =?utf-8?B?aU1USy9TSzgvOGFBU1grQkpEb1VRUno4c0w5SlFPZ21LTVZIdHp6bXU5RGs4?=
 =?utf-8?B?Zk1Bc09iazNNcytqdzR0SWFTZU9YcGI4QnIrZTR5Myt5Y0hzMlVYTzZHa3JR?=
 =?utf-8?Q?nxumiCtV4QhYf+Esb8TAe8jN3Qdplyvm1Lkm4RKIbqxL4?=
X-MS-Exchange-AntiSpam-MessageData-1: BmEXaQVFuHFrKQ==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb4d597-26cc-4873-deb9-08da543fefbf
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2526.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 11:11:21.0066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TqZ9TpW6QmYdIZM+p4+TgMrhucA7BIjbvykiYRgBxmPTfMXaNjwyrEtgeeeuJS+lQj2VUS2CTzvEe0nWa3oz3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6788
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 22.06.22 12:03, David Laight wrote:
> Yes, being able to do short transfers from buffer space in the urb
> would save all the issues about having to allocate an extra
> buffer to avoid DMA from stack.

That is just as hard to do for DMA coherency.

> Indeed for XHCI there is a bit that allows 8 bytes of data to
> replace the pointer in the ring structure itself.
> I don't remember the driver every doing that.

XHCI does use it. There was even a bug with endianness.

	Regards
		Oliver


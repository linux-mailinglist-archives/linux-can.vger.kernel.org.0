Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B444DD4EB
	for <lists+linux-can@lfdr.de>; Fri, 18 Mar 2022 07:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbiCRG5W (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 18 Mar 2022 02:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiCRG5V (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 18 Mar 2022 02:57:21 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBB12414CB
        for <linux-can@vger.kernel.org>; Thu, 17 Mar 2022 23:56:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ciWwDesFURMgFu6dK2uo/EOkK/nOdPdjdolNFMUBp5qMBAFPQmaCD464Qv3V9ClOXbMWXJHQCJq4jyP8zitvHZCTa4Wc67w02aMAojquI33QEJ5uiEbpyVjImbb3aWKbUCmhDzewxELxfZ55pxnys6Yj8QzINW1a+6QOwb5e4bff1bm1qpeOzplNLTfFy1jZkSizHJNqSWoniQDaiKajlZXKRSCb2uXD1xy6E/sHhfw9CfKPBxJh106gxkJp6Zj9soMHuU9MwWQVFVsLIOdbQwsk4xArl3/9C5XMogYiXE3q5pIv72KHk2CYwD+NniKR5SPYWs6a5AUN1seTtkPA2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFiXw1JrhQ09a7KCLUbIPypM7eZ8snkXi6uvgbxU0rM=;
 b=VK6aC81XVrmVZQvdQeSa7KEAoDaccsL9BK5z3rK2JGCiETH+ZT3Sgvm9LTJz/jZRWIZuq8AGPYkSHRVtd01rOskxRXfhU8lQaPC/rrSsrWNXOtsWpTYVoNmO4+YVCdLE03ay5dycM2h65ghaIdYVbQfAMTAkmtiSyFKEnqhu8gPnKRhVMxRqFY0RJbHaguXJbpxRiS75SwnWVzUfVTCmdHq2HdMpDFfNhC9M+uxPKJYxKV3N5kknnZs3stDdpCH6/HmTPtKakGL4WyyLlCl3fB0d+XK8PQw3dz7sxpnIoHzEw3/Nb6LaYVMEb/ZCEPfMn3jCbYL6Rl66EfdmDukhsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFiXw1JrhQ09a7KCLUbIPypM7eZ8snkXi6uvgbxU0rM=;
 b=HGXN18aVSBrY+Kt8IDJRxevdbu9QOn6XNNgXRkUKqBKgq4ynjuJv67nEY7NVVrpev/KjPeDc2hSEzxvpcikA7HuMJtglOmvP9CKM2OP/s7gjh8CGMGN0gtymT52rOhD/fGatLiKzDw16uDsx8g6MR9ZDW18TzCx1gG3xFATEQpk=
Received: from DM6PR02MB5386.namprd02.prod.outlook.com (20.177.221.89) by
 DM6PR02MB6266.namprd02.prod.outlook.com (10.141.167.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.25; Fri, 18 Mar 2022 06:55:56 +0000
Received: from DM6PR02MB5386.namprd02.prod.outlook.com
 ([fe80::b990:6b88:f32f:1e9d]) by DM6PR02MB5386.namprd02.prod.outlook.com
 ([fe80::b990:6b88:f32f:1e9d%6]) with mapi id 15.20.5081.018; Fri, 18 Mar 2022
 06:55:56 +0000
From:   Srinivas Neeli <sneeli@xilinx.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     Srinivas Goud <sgoud@xilinx.com>,
        Naveen Kumar Gaddipati <naveenku@xilinx.com>,
        Prasad Beer Prasad <prasadbe@xilinx.com>,
        linux-can <linux-can@vger.kernel.org>,
        =?utf-8?B?U3RlZmFuIE3DpHRqZQ==?= <stefan.maetje@esd.eu>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Subject: RE: Queries on CAN frame work
Thread-Topic: Queries on CAN frame work
Thread-Index: AdgIqTVMB9fKzsHaTwKoGWnAYyrjVgAEyNAAAAFntwAAaVWWgAcyW0GgBMgvMgAAEDeMUA==
Date:   Fri, 18 Mar 2022 06:55:56 +0000
Message-ID: <DM6PR02MB538652DBE943788F4686531BAF139@DM6PR02MB5386.namprd02.prod.outlook.com>
References: <DM6PR02MB538645C4ECE3BBBD3CE92A17AF539@DM6PR02MB5386.namprd02.prod.outlook.com>
 <20220113203004.jf2rqj2pirhgx72i@pengutronix.de>
 <20220113211018.tqddyiix3vy5q3eq@pengutronix.de>
 <20220115232621.4ybmmrmgogies3o5@pengutronix.de>
 <DM6PR02MB538689AA158B340FE287CF05AF3A9@DM6PR02MB5386.namprd02.prod.outlook.com>
 <20220317225058.3gdvlqnwu5arzbfj@pengutronix.de>
In-Reply-To: <20220317225058.3gdvlqnwu5arzbfj@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0ccc772-94e4-4460-d22a-08da08ac59f9
x-ms-traffictypediagnostic: DM6PR02MB6266:EE_
x-microsoft-antispam-prvs: <DM6PR02MB62666EB8605D064F14DC6D46AF139@DM6PR02MB6266.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i6juB5PBA89UhJlf7IoFtHLEHrPqvyht5qtYKuTu27uMRhgQ+hps2NzPDjt7DHfwldHTZ7CB5qHGib7Td2HXlNbtBVbsHeRjOvTl0lMiBJB/CU+vFh5I3R16ZXNiM/vrrTBIHRyd7BpliR6tVJUk2/GADdnxd7TUR5lBiciX2iH/2FmqhAmIwNpeEO5dUi2vlYiNjgD5u+oq6iDTCZy/G7peqoGmRbbEbOg1ynNXhlIjcccmv7UIWlYV55aliQcj7f+SJTLEFXmML6c3nzNXDfqityvRLKWw+KicSNNmqA5TsLap29g1pnj0pWxe3vwUOBGb7HgK3wtL1mSSPCvOGzTKuKcHvn3pNzJfj+DwDyefIKexJJnbWuynqV35GdL9eJbRsxN9sloILCC/WYiwnKtm9kcY9qSa0jRi0AP+Pcq2uZISV7/Cij9KjNW6ZDzxQrahKlXUMya0GghdLJpWQO4cSHwwaty9vv6X2lVYX1pIIRJvd7nrCroNm4429qGj+92Qvy1udmRwRh7368iZAFwBVS1ohyaL8JM/vIbxbgJSpFZkxSqJ0KBk6rqgjlTDlg8EZ6cCX94iyoH7tLKA1u8cUfKbJmhIGpABKbZnv6vbC+l7HMWP93SE8OqfxNDMWnFwbWi5P4PDIUjSSQqaCNJna1qHmds5ToNjbOjrbQFYlVmSU5haJq8keFCNlWHQoZxxpZ10DSL1C0VxgUo1IrliIaWzYrkp40nmrjDla84Y6Mnyel8tWsrizUBo+XlUnzsBar+v9+6FdSbfqbSJf6R6JAYzY2UDBdmxoT+Y7+U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB5386.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(55016003)(966005)(83380400001)(66574015)(186003)(26005)(2906002)(33656002)(53546011)(9686003)(7696005)(6506007)(122000001)(71200400001)(66946007)(66446008)(4326008)(54906003)(8676002)(38070700005)(64756008)(66476007)(66556008)(38100700002)(8936002)(6916009)(316002)(5660300002)(52536014)(86362001)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ek44azAwSmd1eHdHcDUrYmFGWEVTRW9rOGxkaVlEVTNBc2lVeXl2aWJ5QWdR?=
 =?utf-8?B?QXBtSC9ZTXBNbE5kdUt5ckJuTzhyNjh1YVdVV0xQZEpZTitNNEZERUpTMzBk?=
 =?utf-8?B?UEk0QzRTa0JIeDdxUGRSa0xhb25salVVNE9uL1VmWEVtMGtlLzlaaHZySnEz?=
 =?utf-8?B?QUcza1JXWXZGU2VFUXh6akgyM3BvdzJ1Uzk3bG10S1I0TXRYajNZajZZRnJL?=
 =?utf-8?B?MHlqamxUajByMFlKbmw3TzgrcGRseTY0aUhmS1cxSno5QW9XcDA5MnNJUVNL?=
 =?utf-8?B?Wi8vQlhsR1ZVRFpybmkwa3ZXQUlyeWtMd0xDZ1JpOTQzOVU4Ymhzd2dHb0tF?=
 =?utf-8?B?RHVSVXFNcFZVL2FjT1BIdWVmdUpGZUEwZEhqd2VHWWI0Q2dzUUk3bGlSMU1X?=
 =?utf-8?B?eWJXbDM5OC9nWm5wbkNnODVrazhUUzlRdld4UzYxZ25UcVBPS3V5czR1SGE0?=
 =?utf-8?B?NjZMM2pCVytWYkNRNHVJRmhXMk1JQ20vU2Y3MVo4d3JicFpoL2FiL24zTDZm?=
 =?utf-8?B?ZFpxd2FHc0MvR25ZRkZMSVcvc2dlMlpPWkN0TFZraHhmSlIrMnlTNXlDRCtF?=
 =?utf-8?B?NUJaejY0M3B3Uk5kcm1vR0dGWHArTWNBc004MmxWdFpsclE3WTdjVm94UUh5?=
 =?utf-8?B?dFJwQzFJSkFFWmphSkY3YXR3TUhCQm0rY0pIaVRIclpIOU1PYklwYytibmZE?=
 =?utf-8?B?VzIrQ3h5bStGTVVIOTJpdnc0dzBMbnpTUXgrcEpiMmdNRS9BMGlETXJrcUJW?=
 =?utf-8?B?djIvRnJ5K2lkaWhpU29kR05lejM0UGJGWVR4ODRGOVhoQnFOYkFjMGRCb2tR?=
 =?utf-8?B?WE56VjVXeXo5b3pEWHFIbTRGcW9WdG56ZTJtY2taWEd3SWI3T1FRdmM2QVM4?=
 =?utf-8?B?NGpTV2pyMFF4blYzNFpkNFNSVllBeDhsczZJZ05nbFQ3UDdHSHZadjd4NjFL?=
 =?utf-8?B?cm90d3ltM2Rra1F6SWdBWEhwN2JnNW5xbWthb2pzZkVjOWRWQjlFV2xOZnlI?=
 =?utf-8?B?T1pKSjVJM0pOMVF2YVMzSW15bmFXQ29pZWljNGxVaWFvaC9MbS9pWU5MQXlL?=
 =?utf-8?B?K1Fva2hEcjJUL1hScUFNU0RvUUs0c2tGeXZaNVNrUHBRL2hUMkFBQjBRLy9Z?=
 =?utf-8?B?T2JwQ2phMjhjTXJXTlQrM1p6eXVrNTkrWW9xcTJZTllQdGtnSCt2ZlVzR2Z4?=
 =?utf-8?B?UmxxTzExSGUxbW9TMUgrckx4TXdWMThFTW13QlNiUmlNcFNDNmx3aHBXNUV6?=
 =?utf-8?B?YnZrSTFaODljaDlJVCtER2Jyb0xvMlhreDVGZExnNFpTVXhxTmhyLzFNUjVo?=
 =?utf-8?B?NS81QTVGSUIxT0l0L1VWVGljYURQTFFIak92Z0JuV3NsRThVZS9GRXJvczJw?=
 =?utf-8?B?S2h1NjhkQnNvbmtjbmlpbmJ0SDFZMEN0ZkNRUFVzK0pKK01tVTVXV3ZwRmc1?=
 =?utf-8?B?ZlFLM3lHbVBGM3N4TUU3NDFmcFF1Uk5qNnlUTm0reW5mVjFqM1FnVnZCdmNF?=
 =?utf-8?B?R0ZMZnIrUlE5Mk14dk5JRlRMNkFVTjNuaDZrL2ZHTGJBSjlGSFVYMTlXMDlo?=
 =?utf-8?B?R2p1bEdQeUdhSm5XNW84cEtJRGEzT3ZoRXRmY1A5TXhteE1pVDFMZU01QTl3?=
 =?utf-8?B?cXd0cmdJRVpSd09tRVlWRldicUpXbjJ5Z0dFejIwbm9MZHpDTTBRTmZ1U0pt?=
 =?utf-8?B?MGJrQWplNGtqRVpXM3pic0RvR0dmYUdFd3VyN3ZjZkhYbzY5K0NpM211eXlp?=
 =?utf-8?B?NjFSb3hnRzdaWEc2ZHJzVS80Um91dC9ackIvNDN2ZUpwdldWRU5HanUxVzVF?=
 =?utf-8?B?U3JYMy9oT0pKOUF6TVJUK0NBZ2RldHYvdUR4V0N6QXJJUEFUa2ExdFcrUTNG?=
 =?utf-8?B?R2dYRk1mS2htVGJRQUExaUZVTmNXUFlZTE9pc3dVRkFOcFRwTVZMWWxaVXkz?=
 =?utf-8?Q?+09LsAB+uGSB8ou+XF+TFvthnoW7hWF+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB5386.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ccc772-94e4-4460-d22a-08da08ac59f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 06:55:56.2194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PF1ffSDjtRTgWFvUyvEZDXIB/VDPCUwJySnpo0A9yKiPj3R63WHfIpLeS7OSwvVgDrBDUxkdp2ev5jlEfVUZUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6266
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGkgTWFyYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJjIEts
ZWluZS1CdWRkZSA8bWtsQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiBGcmlkYXksIE1hcmNoIDE4
LCAyMDIyIDQ6MjEgQU0NCj4gVG86IFNyaW5pdmFzIE5lZWxpIDxzbmVlbGlAeGlsaW54LmNvbT4N
Cj4gQ2M6IFNyaW5pdmFzIEdvdWQgPHNnb3VkQHhpbGlueC5jb20+OyBOYXZlZW4gS3VtYXIgR2Fk
ZGlwYXRpDQo+IDxuYXZlZW5rdUB4aWxpbnguY29tPjsgUHJhc2FkIEJlZXIgUHJhc2FkIDxwcmFz
YWRiZUB4aWxpbnguY29tPjsgbGludXgtDQo+IGNhbiA8bGludXgtY2FuQHZnZXIua2VybmVsLm9y
Zz47IFN0ZWZhbiBNw6R0amUgPHN0ZWZhbi5tYWV0amVAZXNkLmV1PjsNCj4gVmluY2VudCBNQUlM
SE9MIDxtYWlsaG9sLnZpbmNlbnRAd2FuYWRvby5mcj4NCj4gU3ViamVjdDogUmU6IFF1ZXJpZXMg
b24gQ0FOIGZyYW1lIHdvcmsNCj4gDQo+IE9uIDIxLjAyLjIwMjIgMTQ6NDM6NTcsIFNyaW5pdmFz
IE5lZWxpIHdyb3RlOg0KPiA+ID4gQ2FuIHlvdSBhbHNvIHByb3ZpZGUgdGhlIGhhbmQgY2FsY3Vs
YXRlZCBiaXQgdGltaW5nIHBhcmFtZXRlcnMgZm9yDQo+ID4gPiB0aGUgYWJvdmUgc2NlbmFyaW9z
Pw0KPiA+DQo+ID4gQmF1ZCByYXRlIDEvNU1icHMNCj4gPiA9PT09PT09PT09PT09PT09DQo+ID4N
Cj4gPiBIYW5kIGNvbmZpZ3VyYXRpb246DQo+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
DQo+ID4gaXAgbGluayBzZXQgY2FuMCB0eXBlIGNhbiB0cSAxMiBwcm9wLXNlZyAyOSBwaGFzZS1z
ZWcxIDMwIHBoYXNlLXNlZzINCj4gPiAyMCBzancgMSBkdHEgMTIgZHByb3Atc2VnIDUgZHBoYXNl
LXNlZzEgNiBkcGhhc2Utc2VnMiA0IGRzancgMSBmZCBvbg0KPiA+IChBL0Q6IDEvNU1icHMsIFNh
bXBsZSBwb2ludD03NSUpDQo+ID4NCj4gPiBCYXVkIHJhdGUgMS80TWJwcw0KPiA+ID09PT09PT09
PT09PT09PT0NCj4gPg0KPiA+IEhhbmQgY29uZmlndXJhdGlvbjoNCj4gPiAtLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KPiA+IGlwIGxpbmsgc2V0IGNhbjAgdHlwZSBjYW4gdHEgMTIgcHJvcC1z
ZWcgMjkgcGhhc2Utc2VnMSAzMCBwaGFzZS1zZWcyDQo+ID4gMjAgc2p3IDEgZHRxIDEyIGRwcm9w
LXNlZyA3IGRwaGFzZS1zZWcxIDcgZHBoYXNlLXNlZzIgNSBkc2p3IDEgZmQgb24NCj4gPiAoQS9E
OiAxLzRNYnBzLCBTYW1wbGUgcG9pbnQ9NzUlKQ0KPiANCj4gSSd2ZSB1cGRhdGVkIHRoZSBhbGdv
cml0aG0gdG8gcHJlZmVyIGxvd2VyIGJycCB2YWx1ZXMuIENhbiB5b3UgY2hlY2sgaWYgdGhlc2UN
Cj4gdmFsdWVzIG1ha2Ugc2Vuc2UgdG8geW91Pw0KDQpUaGFua3MgZm9yIHVwZGF0ZS4NCkZldyBt
b3JlIGNoYW5nZXMgbmVlZCB0byB1cGRhdGUgaW4gYWxnb3JpdGhtLg0KMSkgQ2hvb3NlIFNKVyBh
cyBsYXJnZSBhcyBwb3NzaWJsZSAod2UgY2FuIGFzc2lnbiAiIHRzZWcyIikNCg0KIEZvciBDQU5G
RCBDSUEgcmVjb21tZW5kYXRpb25zIDoNCiBSZWNvbW1lbmRhdGlvbiAxOiANCiAgICBDaG9vc2Ug
dGhlIGhpZ2hlc3QgYXZhaWxhYmxlIENBTiBjbG9jayBmcmVxdWVuY3kgKDIwIE1IeiwgNDAgTUh6
LCA4MCBNSHopIA0KUmVjb21tZW5kYXRpb24gMjoNCiAgICBTZXQgdGhlIEJSUEEgYml0LXJhdGUg
cHJlLXNjYWxlciBlcXVhbCBCUlBEDQpSZWNvbW1lbmRhdGlvbiAzOg0KICAgIENob29zZSBCUlBB
IGFuZCBCUlBEIGFzIGxvdyBhcyBwb3NzaWJsZS4NClJlY29tbWVuZGF0aW9uIDQ6IA0KICAgIENv
bmZpZ3VyZSBhbGwgQ0FOIEZEIG5vZGVzIHRvIGhhdmUgdGhlIHNhbWUgYXJiaXRyYXRpb24gcGhh
c2UgU2FtcGxlIHBvaW50IChTUCkgYW5kIHRoZSBzYW1lIGRhdGEgcGhhc2UgU1ANClJlY29tbWVu
ZGF0aW9uIDU6IA0KICAgIENob29zZSBTSldEIGFuZCBTSldBIGFzIGxhcmdlIGFzIHBvc3NpYmxl
IChiZXN0IGlzIHRoZSBtYXggcG9zc2libGUgdmFsdWUpDQpSZWNvbW1lbmRhdGlvbiA2OiANCiAg
ICBFbmFibGUgVERDIHdoZW4gbmVlZGVkIA0KICAgICBJZiB3ZSBlbmFibGUgVERDIGZlYXR1cmUg
LHBsZWFzZSB0cnkgdG8gY29uZmlndXJlIGJycCB2YWx1ZSAxIGluIGFsZ29yaXRobShUREMgZmVh
dHVyZSBzdXBwb3J0IGJycCAxLzIgYnV0IG9ic2VydmVkIGdvb2QgcmVzdWx0cyB3aXRoIDEpLg0K
PiANCj4gfCAkIC4vY2FuLWNhbGMtYml0LXRpbWluZyAtLWFsZz1jYW4tbmV4dCB4aWxpbnhfZHdu
c3RybSAtYyA3OTk5OTk5OSBCaXQNCj4gfCB0aW1pbmcgcGFyYW1ldGVycyBmb3IgeGlsaW54X2R3
bnN0cm0gd2l0aCA3OS45OTk5OTkgTUh6IHJlZiBjbG9jayAoY21kLQ0KPiBsaW5lKSB1c2luZyBh
bGdvICdjYW4tbmV4dCcNCj4gfCAgbm9taW5hbCAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICByZWFsICBCaXRydCAgICBub20gICByZWFsICBTYW1wUA0KPiB8ICBCaXRyYXRlIFRRW25z
XSBQclMgUGhTMSBQaFMyIFNKVyBCUlAgIEJpdHJhdGUgIEVycm9yICBTYW1wUCAgU2FtcFAgIEVy
cm9yDQo+IHwgIDEwMDAwMDAgICAgIDEyICAyOSAgIDMwICAgMjAgICAxICAgMSAgIDk5OTk5OSAg
IDAuMCUgIDc1LjAlICA3NS4wJSAgIDAuMCUNCg0KT2JzZXJ2ZWQgZGlmZmVyZW50IEJSUCB2YWx1
ZXMgZm9yIDFNYnBzIGluIGhlcmUgYW5kIGJlbG93IGxpc3QgZm9yIHNhbWUgc2FtcGxpbmcgcG9p
bnQuDQoNCj4gfCAgIDgwMDAwMCAgICAgMTIgIDM5ICAgNDAgICAyMCAgIDEgICAxICAgNzk5OTk5
ICAgMC4wJSAgODAuMCUgIDgwLjAlICAgMC4wJQ0KPiB8ICAgNjY2NjY2ICAgICAxMiAgNDcgICA0
OCAgIDI0ICAgMSAgIDEgICA2NjY2NjYgICAwLjAlICA4MC4wJSAgODAuMCUgICAwLjAlDQo+IHwg
ICA1MDAwMDAgICAgIDEyICA2OSAgIDcwICAgMjAgICAxICAgMSAgIDQ5OTk5OSAgIDAuMCUgIDg3
LjUlICA4Ny41JSAgIDAuMCUNCj4gfCAgIDI1MDAwMCAgICAgMjUgIDY5ICAgNzAgICAyMCAgIDEg
ICAyICAgMjQ5OTk5ICAgMC4wJSAgODcuNSUgIDg3LjUlICAgMC4wJQ0KPiB8ICAgMTI1MDAwICAg
ICA1MCAgNjkgICA3MCAgIDIwICAgMSAgIDQgICAxMjQ5OTkgICAwLjAlICA4Ny41JSAgODcuNSUg
ICAwLjAlDQo+IHwgICAxMDAwMDAgICAgIDUwICA4NyAgIDg3ICAgMjUgICAxICAgNCAgICA5OTk5
OSAgIDAuMCUgIDg3LjUlICA4Ny41JSAgIDAuMCUNCj4gfCAgICA4MzMzMyAgICAgNTAgMTA0ICAx
MDUgICAzMCAgIDEgICA0ICAgIDgzMzMzICAgMC4wJSAgODcuNSUgIDg3LjUlICAgMC4wJQ0KPiB8
ICAgIDUwMDAwICAgIDEwMCAgODcgICA4NyAgIDI1ICAgMSAgIDggICAgNDk5OTkgICAwLjAlICA4
Ny41JSAgODcuNSUgICAwLjAlDQo+IHwgICAgMzMzMzMgICAgMTI1IDEwNCAgMTA1ICAgMzAgICAx
ICAxMCAgICAzMzMzMyAgIDAuMCUgIDg3LjUlICA4Ny41JSAgIDAuMCUNCj4gfCAgICAyMDAwMCAg
ICAyNTAgIDg3ICAgODcgICAyNSAgIDEgIDIwICAgIDE5OTk5ICAgMC4wJSAgODcuNSUgIDg3LjUl
ICAgMC4wJQ0KPiB8ICAgIDEwMDAwICAgIDUwMCAgODcgICA4NyAgIDI1ICAgMSAgNDAgICAgIDk5
OTkgICAwLjAlICA4Ny41JSAgODcuNSUgICAwLjAlDQo+IHwNCj4gfCBCaXQgdGltaW5nIHBhcmFt
ZXRlcnMgZm9yIHhpbGlueF9kd25zdHJtIHdpdGggNzkuOTk5OTk5IE1IeiByZWYgY2xvY2sNCj4g
KGNtZC1saW5lKSB1c2luZyBhbGdvICdjYW4tbmV4dCcNCj4gfCAgbm9taW5hbCAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICByZWFsICBCaXRydCAgICBub20gICByZWFsICBTYW1wUA0K
PiB8ICBCaXRyYXRlIFRRW25zXSBQclMgUGhTMSBQaFMyIFNKVyBCUlAgIEJpdHJhdGUgIEVycm9y
ICBTYW1wUCAgU2FtcFAgIEVycm9yDQo+IHwgMTIwMDAwMDAgICAgIDEyICAgMiAgICAyICAgIDIg
ICAxICAgMSAxMTQyODU3MSAgIDQuOCUgIDc1LjAlICA3MS40JSAgIDQuOCUNCj4gfCAxMDAwMDAw
MCAgICAgMTIgICAyICAgIDMgICAgMiAgIDEgICAxICA5OTk5OTk5ICAgMC4wJSAgNzUuMCUgIDc1
LjAlICAgMC4wJQ0KPiB8ICA4MDAwMDAwICAgICAxMiAgIDMgICAgMyAgICAzICAgMSAgIDEgIDc5
OTk5OTkgICAwLjAlICA3NS4wJSAgNzAuMCUgICA2LjclDQo+IHwgIDUwMDAwMDAgICAgIDEyICAg
NSAgICA2ICAgIDQgICAxICAgMSAgNDk5OTk5OSAgIDAuMCUgIDc1LjAlICA3NS4wJSAgIDAuMCUN
Cj4gfCAgNDAwMDAwMCAgICAgMTIgICA3ICAgIDcgICAgNSAgIDEgICAxICAzOTk5OTk5ICAgMC4w
JSAgNzUuMCUgIDc1LjAlICAgMC4wJQ0KPiB8ICAyMDAwMDAwICAgICAxMiAgMTQgICAxNSAgIDEw
ICAgMSAgIDEgIDE5OTk5OTkgICAwLjAlICA3NS4wJSAgNzUuMCUgICAwLjAlDQo+IHwgIDEwMDAw
MDAgICAgIDI1ICAxNCAgIDE1ICAgMTAgICAxICAgMiAgIDk5OTk5OSAgIDAuMCUgIDc1LjAlICA3
NS4wJSAgIDAuMCUNCg0KSGVyZSBicnAgPTIgYW5kIGluIGFib3ZlIGxpc3QgYnJwID0xLg0KDQo+
IA0KPiByZWdhcmRzLA0KPiBNYXJjDQo+IA0KPiAtLQ0KPiBQZW5ndXRyb25peCBlLksuICAgICAg
ICAgICAgICAgICB8IE1hcmMgS2xlaW5lLUJ1ZGRlICAgICAgICAgICB8DQo+IEVtYmVkZGVkIExp
bnV4ICAgICAgICAgICAgICAgICAgIHwgaHR0cHM6Ly93d3cucGVuZ3V0cm9uaXguZGUgIHwNCj4g
VmVydHJldHVuZyBXZXN0L0RvcnRtdW5kICAgICAgICAgfCBQaG9uZTogKzQ5LTIzMS0yODI2LTky
NCAgICAgfA0KPiBBbXRzZ2VyaWNodCBIaWxkZXNoZWltLCBIUkEgMjY4NiB8IEZheDogICArNDkt
NTEyMS0yMDY5MTctNTU1NSB8DQo=

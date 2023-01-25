Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468C667AAA7
	for <lists+linux-can@lfdr.de>; Wed, 25 Jan 2023 08:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbjAYHAW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 25 Jan 2023 02:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbjAYHAF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 25 Jan 2023 02:00:05 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3227474EE
        for <linux-can@vger.kernel.org>; Tue, 24 Jan 2023 22:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1674629999; x=1706165999;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=e1COIBxR/YP2xPfLcZES1aES7CnANsywOsxiwRfKTLE=;
  b=xxc9Qun531AWFMJnADH6Ga9slf6F7uo7C7J/dmuZYJZ1i0ZX/m8yjVb6
   SgRkm4joXTFCI/1bGgKjkG15U7qIpqWJIGNZhSifx5EG+aUZUZorDMK2r
   CtZooMUnLq3UnQLIwV+xXhBohKAniFeyFLxVqM2BB9M+BirsosFxyqRjG
   a5XuHOE3W21oTvbzEbDey6OL9XcKToDKIovM08TUwnLNKGjuTdsE3abxl
   1G/MEYvBXo/reZTOGfb0IiWtMnNyGYEyuuKA3Sr4W9ZzuFLaMC1ACpgUl
   VGx/lJo8yBOwqlT8tz2rQ6VCCp0yr5bRuBCrKYhjGLezgV6gTagDUUSR/
   w==;
X-IronPort-AV: E=Sophos;i="5.97,244,1669100400"; 
   d="scan'208";a="193755899"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Jan 2023 23:59:58 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 24 Jan 2023 23:59:58 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 24 Jan 2023 23:59:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7NBXWAZ1c4FsMQFhKNC/L6/tr6z92YLkIBejMbWXnHE0fbQtV2HXG/qXrpi18rqy9eoyiJQ2qbDrtoLnWSjWubYtaknKGvvySZp746xEIimHl4ZX3WhVjCL1axViJ3QROpEFkkb40z1SrF6QQBpp1BCfsWImMYHDeM3k12SuRAopHumRo5ZbEqkmTDTNsd+7UNpo/K0AAyQE0l5LNIzKheONiLfN6jq7GBjrTpk2WGxrhRPqKLPaOCOpul5zoQnQBZQq+hfbkEZhBM1tElsY8GCumGoyWtk1ogAmn38wk4o6ABmw3nlFuY6Cm5z5W9ZGURVopjypsJVePig5vk44w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1COIBxR/YP2xPfLcZES1aES7CnANsywOsxiwRfKTLE=;
 b=Mj5EMMlGenQ/I+Au+Xo68UiRQ82zmLQnSRtXem4QccxluAT+Sgmmjbs5MfpoYSWc+bGF+FZQd+BdcgNGFmOuwV/A2c0MgSYM0/dHEAElSeGhsKPaAHuppqtzsLy4ZdczG6Rfl1A28o3jCC2KnOc6Hc4PjZQ7SWeEzvsf6wBNxyDW7vPEaO2e9TzLi/4ceR0uCW962ukN/WB2iSyny8vwguJkmCQoLnHoMVi4Li7bBIc1CvBJ5MangjuEwmmPC77LTE9hlwK9zxwF704pfTSwl5Xp0QPOCqKQz5RCNmMX6XlDYJu0h49/UcXH8mQybIfVsrNPoEn69IyWdc19OJZbCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1COIBxR/YP2xPfLcZES1aES7CnANsywOsxiwRfKTLE=;
 b=Njo5YC7c1zvlK2Io8n4BZZOz9OU4aKoW+TozYMJ2lBcgykZs84GF11wRSfGRN9qa0W9skLBn3mpvnE0ZfbJydud9sQUt9x15rEJ2hrXqSM7KCiV2CU4OR7FjxMAgZox1inWAcC1srKiviZYZQ4zoJJ7KisYKc1F7oAoyMbOGShA=
Received: from BL3PR11MB6484.namprd11.prod.outlook.com (2603:10b6:208:3bf::19)
 by PH0PR11MB5128.namprd11.prod.outlook.com (2603:10b6:510:39::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Wed, 25 Jan
 2023 06:59:56 +0000
Received: from BL3PR11MB6484.namprd11.prod.outlook.com
 ([fe80::cb80:ece0:6de6:f096]) by BL3PR11MB6484.namprd11.prod.outlook.com
 ([fe80::cb80:ece0:6de6:f096%4]) with mapi id 15.20.6002.033; Wed, 25 Jan 2023
 06:59:56 +0000
From:   <Thomas.Kopp@microchip.com>
To:     <tom_usenet@optusnet.com.au>, <mkl@pengutronix.de>,
        <linux-can@vger.kernel.org>
Subject: RE: [PATCH 0/5] can: mcp251xfd: workaround double-RX erratum
Thread-Topic: [PATCH 0/5] can: mcp251xfd: workaround double-RX erratum
Thread-Index: AQHZJgs1ergp/bMJp0qTjmcZ1NcfU66ZzGkAgBTm8QCAAA6KEA==
Date:   Wed, 25 Jan 2023 06:59:56 +0000
Message-ID: <BL3PR11MB6484A5E53B8F85F4D97FB649FBCE9@BL3PR11MB6484.namprd11.prod.outlook.com>
References: <20230111222042.1139027-1-mkl@pengutronix.de>
 <20230111223004.w7z4ghdahe7jvebe@pengutronix.de>
 <a269b5b8-a88d-d2da-5bcf-59f2aac40f87@optusnet.com.au>
In-Reply-To: <a269b5b8-a88d-d2da-5bcf-59f2aac40f87@optusnet.com.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB6484:EE_|PH0PR11MB5128:EE_
x-ms-office365-filtering-correlation-id: a812659c-9719-467b-6205-08dafea1c460
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5qJl/6CN18/cAn5b+rclMmR3FiZfwlebCc9oGIH2MQqtLSuCYJPSEahf6K6v5RoUz/iXbJppXq1YU67j5V2UcgZnI6/dn5/wdHTzEfBiE+zT+C5/s1qV4wggrtCeYSY070GPHTbwml0WDp0LTY0QRfBacBUMHksx4pNUcfyVkFoGXADY1Pa4yscVwR7C1YkoyIb6Yj9kmWrdrWZd03AsVmXtW79QjYe6q1co5MlXSS0mWTX30huiHzoUv2Yp0xGnJ1FHo4cjnIF6/hS/tB03f4IfDJGgbcdHmQicpnbx2KizgY7IVjQ047vOBDhHZxVe+c8+JaGMNY16JMhmvpRuDukZlO2wgF0XmAAS15w1s1bFtK49J8f0HqPTis8c7hq7vv7KvfGUtU6OkWrgAkKSGLJYNNsqNZxjkukgCj+NssmZ2R8wxBHRsQ9TrGXowHl6eT/IAevUsgP8amlGDqA3cUV7mtFW4U0QcSG7FeUqPZGrZVz1KqW+qWpXQBSqJnPzmGc4PSZwp28GpAYwfjgB2esQOA8Jt3GZjORxbXeAjH5Awq4ih90ypoRVIQA8SpqJa5WjIXnD5xUqx+g5Mtnxp7AHW85bTfPpxtRPcdLC03M+dKAPpzrs4/S85QWFpMjq6YTr7N5eBsK2f1mb5DI1VQSyDvONQ6X4lHD1had6Sy4fWHO1590x7HC7zPMFl+COl0SLrGgQrf3xS0jiFgn4kQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6484.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199018)(33656002)(122000001)(38100700002)(9686003)(83380400001)(41300700001)(86362001)(6506007)(8936002)(26005)(52536014)(5660300002)(55016003)(66946007)(186003)(316002)(38070700005)(66556008)(64756008)(8676002)(66476007)(110136005)(2906002)(71200400001)(7696005)(76116006)(478600001)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlBEb0FpeXNKT3BsZ3V2bjBFZDRlM2pSQTNTbSt5NmkxUGJZSEJaQ3Q3T1Zm?=
 =?utf-8?B?ZlYrYkMzaVNtQjl5Z2lYQUFRaFhDWEMvM2xLb0U0c1F4OWtQUmtsL0Y3TG9j?=
 =?utf-8?B?bFJoUDNDb0dCOEM2aWZUa1owbS9QK1VFV0NxblFsVnBZM3JYSHFMN290Ukpl?=
 =?utf-8?B?T2R0Y0xyZHZPN01oZWtiTnpHNFI4cnltMWlhWk5KbEgzOWY2MjdPZS9QYVY4?=
 =?utf-8?B?RkdUUVRjTng0WTBvSW8yZTlXNjNjQ3plZytKSzR3VXBpUzZHU3QyMTFvbDls?=
 =?utf-8?B?SUNHRWlJYlpaTUZDZUdxenU5bUoxaC9GdGtRUDRFTVYrei9MdFpObUM2em16?=
 =?utf-8?B?OUpYZ2U5YnNjRHZsaGZ5T3NsRmw5V01OSDJGaHVKNU5CczJ6a1ZPLzRlNDFI?=
 =?utf-8?B?bnk1dTVyR0FjcGNDdHZtMW5mbDdpQm80TElTd2dReThWczlacUU4R1pXZ0JQ?=
 =?utf-8?B?TWhNZzV1eWo3cC9UbHJXY1pONE41SUJ0SlBRaThvSW1GUGJGelR1SDVsN0FT?=
 =?utf-8?B?MDUxN0dXWFlaUUJGWUdqVTdKT0xlQ2pPWjRVa2dlT3hka2JvVkYwV3g0K0dr?=
 =?utf-8?B?cjVHenVPY2hsZWhHeDZqWlExQW01NjJBQkF5aUtTNXYxSHpwTGFHeHFVelRo?=
 =?utf-8?B?ZmZRVlJLRzZDWmt6dVZWYzhObFB3UUNUSnZBV2dFUlA1eTdCbXFuS3MzdnBC?=
 =?utf-8?B?RmROdW5mZlU4WDREY0NGdmIwRTRPZlRTVUFXRThBcC9hd2t2SXcvU2k3aGlh?=
 =?utf-8?B?ZXZqOTh4Q0xtanNsejJ0UkpUczZVeWE0OWpiZGZIMUxnVXQ2c2w5cHRJT0U1?=
 =?utf-8?B?bExOcEhTVzVXV0djTEwyUGhSUkpJQ1hHYmdCUmdXVlpqdWgvVXN3aDAzam1C?=
 =?utf-8?B?eVVyYmFYK2lQU294cjFDYzNPYndmL2E2VGdPeUtnSlFTZTZGelArc1hvZ0U0?=
 =?utf-8?B?MFU2MXlWZEpKc2c3ajZDbFdJckVhaDRyQXFNR3o2MjRPQVFzNHcxQU5DWkpO?=
 =?utf-8?B?MGw2TXQ3Y2x0dVU4dHdOS3ZPT0tMSVd0cFdPamdUWkhRQjE4eEFucm1HU0pp?=
 =?utf-8?B?Z3RGME5KQk1vZzRkTU5ZZGZHY0RsSmx3a20zdWc5QVp6cExCcVM4ZGpTQTdR?=
 =?utf-8?B?cnVHKzJmaGdMOFBjbWRKR0Rnb25sQSsyZk1KL3FsWVk0d3VnVWFTR1pFZVRz?=
 =?utf-8?B?M1kzeEF6dHExYm5TNDZxbkpuSTNUYzhRVkVPWDlwbTgyWk5CV0doVTdaMHlq?=
 =?utf-8?B?Q29JN0FzUUNtS2xlaVo1U0hQQTlBVnZGakVlMlR4KzRpVFRtak81RisyZWQ3?=
 =?utf-8?B?YkQ5UTQ3YlBHVDRtUTJza2N1Q3J3OGg4TlBCTWlXM0ZxYllOV2ZoSzRsYllq?=
 =?utf-8?B?UGFWRXVIb1pkTVlEdkJZc1NIdlZjVEpoa0J0NGpXR0IyakplSUV0enFDNy9O?=
 =?utf-8?B?aXhXaUYrMEZWenkxQmlGamV3LzZBK0ZxcnZvSDh1WDlSMEdLYStUQjEycm1X?=
 =?utf-8?B?Vnd4UzVrc3h0YjFSQ1BSc1FxZlhzM2gzSGhMT05pOUdOcEorcC9WOFNyMDBZ?=
 =?utf-8?B?VFNRL3BEVkxuUFNxQkFqMER2TGo1aHZNTWh6c3RYTkVlZHhYOWpUMW9VRitE?=
 =?utf-8?B?T3ltVHVVc2k3T1hLM3NoYngxekFldUdoUlJYaXFHTGF0OUdXVjV0VEY2VUJM?=
 =?utf-8?B?eTcrT3pESVNpWlpqTlVtTTdTSjgxS1loSGVOTFZxTms4S3lNL1VQUWRTUTYr?=
 =?utf-8?B?QXpKc29qZE1qK3dvQlRtT2tsbVdIWGRBK2tqalBid2xwWmYxWVpmaXVROXpv?=
 =?utf-8?B?MFpGb2F2OWtLS3dySE5mRVpPS2dvTEVhV3J4TFpuOGY4OE9JdnZxM3hQQVJS?=
 =?utf-8?B?VnUyMWlzdmlMZjRETjJpTCs4cjJlNlU3VzBOa05ncEZzZlFvbjNDZ3lSZkNU?=
 =?utf-8?B?Z3FaWUwrcDlCRXVLSEhVa0lxd0IxQ3FFdzdjNWxVUUZFTVBTLzRIRFJFNkxi?=
 =?utf-8?B?MGl0aVg4MW1saTZRS0FMVnNGRk8wTG5TOGZtdkNCdzFhV0RVZzZCUGZZSDFF?=
 =?utf-8?B?Rmh5THVrOXEzc3hzMmw5Ym8xWjQzcDMzQVdQczRQR0dtazkrVXBmbFJDZjhQ?=
 =?utf-8?B?WUJLemRTNExBY2ZSaW5EdjgycnN2OEo4TGRnd3A0dDRpZC9yWEJnYm9kdXQw?=
 =?utf-8?B?NHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6484.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a812659c-9719-467b-6205-08dafea1c460
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2023 06:59:56.3718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9ZnNGMwSRSq94pTiuqQ6bLJ5UzP3TJc5zOHetMRycILlPDTC825gvrD1fS+WMZiOEPZV4Uy8mZQvQBPRhklyKkjLTVbU8y2OukLbdS9WLVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5128
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

SGkgVG9tLA0KDQo+ID4+IFdpdGggdGhlIGhlbHAgb2YgVGhvbWFzIHdlIGZvdW5kIG91dCB0aGF0
IHRoZSBjaGlwIGhhcyBhIHRpbWUgd2luZG93DQo+ID4+IGFmdGVyIHJlY2VpdmluZyBhIENBTiBm
cmFtZSB3aGVyZSB0aGUgUlggRklGTyBTVEEgcmVnaXN0ZXIgY29udGVudCBpcw0KPiA+PiBub3Qg
cmVhZCBjb3JyZWN0bHkuDQo+IA0KPiBUaGlzIGlzIGJlaW5nIGNhbGxlZCBhbiAiZXJyYXR1bSIu
IEkgdGFrZSB0aGF0IHRvIG1lYW4gYW4gYWRtaXR0ZWQgYnVnDQo+IHB1Ymxpc2hlZCBieSB0aGUg
Y2hpcA0KPiBtYW51ZmFjdHVyZXIuIEhhcyB0aGVyZSBiZWVuIGFueSByZXNwb25zZSBmcm9tIE1p
Y3JvY2hpcCBvbiB0aGlzIHlldD8gSWYNCj4gdGhleSBjb3VsZCBwcm9wZXJseQ0KPiBkZXNjcmli
ZSB3aGF0J3Mgd3JvbmcsIGl0IG1pZ2h0IGxlYWQgdG8gbW9yZSByb2J1c3Qgd29yayBhcm91bmRz
Lg0KVGhhdCdzIHRoZSBwbGFuLCB5ZXMuIFdlIGRvbid0IGhhdmUgc2ltdWxhdGlvbnMgeWV0IHRv
IGZ1bGx5IGV4cGxhaW4gd2hhdCdzIGdvaW5nIG9uIGFuZCBtb3JlIGltcG9ydGFudCB0byBtYWtl
IHN1cmUgdGhhdCBub3RoaW5nIGlzIG1pc3NlZC4gT25jZSB0aGF0IGlzIGZ1bGx5IHVuZGVyc3Rv
b2QgSSdsbCB1cGRhdGUgdGhlIGVycmF0YXNoZWV0LiBJbiB0aGUgbWVhbnRpbWUgSSB0aGluayBp
dCBtYWtlcyBzZW5zZSB0byB3b3JrIG9uIGFuZCB0ZXN0IHRoZSB3b3JrYXJvdW5kLiBUaGlzIHdh
cyB0aGUgYXBwcm9hY2ggZm9yIHRoZSBtYXggc3BpIGZyZXF1ZW5jeSBidWcgYXMgd2VsbC4gVGhl
IGluaXRpYWwgd29ya2Fyb3VuZCBiYXNlZCBvbiB0ZXN0aW5nIG9ubHkgd2FzIGxpbWl0aW5nIHRo
ZSBjbG9jayB0byA5Mi41JSBvZiBjbGsvMih3aGljaCBwcm92ZWQgcHJldHR5IHJvYnVzdCBpbiB0
ZXN0aW5nKSBhbmQgd2FzIHRoZW4gY2hhbmdlZCB0byB0aGUgbm93IGluIHBsYWNlIDg1JS4NCklm
IHlvdXIgc3VnZ2VzdGlvbiB3YXMgdG8gY2FsbCBpdCBidWcgdW50aWwgYmVpbmcgYW4gcHVibGlz
aGVkIGVycmF0dW0sIHllcyAtIEkgYWdyZWUgdGhhdCBpdCBtaWdodCB0aGluZ3MgZWFzaWVyIHRv
IGZvbGxvdyBhbmQgc2VlIGF0IHdoaWNoIHN0YXRlIHdlIGFyZS4NCg0KPiBJJ3ZlIG5vdGljZWQg
cGVvcGxlIGtub3cgYWJvdXQgdGhlICJtYXhpbXVtIFNQSSBjbG9jayByYXRlIiwgYW5kIGFyZQ0K
PiBnZXR0aW5nIGNsb3NlIHRvIGl0IGluIHRlc3RpbmcuDQo+IFRoZSBjaGlwIG1pZ2h0IGhhdmUg
bW9yZSAoYW5kIG1vcmUgZnJlcXVlbnQpIHByb2JsZW1zIG5lYXIgdGhhdCBsaW1pdC4NClRoYXQg
c2hvdWxkbid0IGJlIHRoZSBjYXNlLiBUaGUgbWF4IGZyZXF1ZW5jeSBnaXZlbiBpbiB0aGUgZXJy
YXR1bSB3YXMgY2hvc2VuIHNvIHRoYXQgbm90aGluZyBjYW4gaGFwcGVuIGF0IHRoYXQgZnJlcXVl
bmN5IG9yIGJlbG93IHRoYXQgLSBhdCBsZWFzdCBub3QgZm9yIHRoaXMgcGFydGljdWxhciBmYWls
dXJlIG1vZGUuDQoNCj4gVGhlIE1DUDI1MTdGRCBoYXMgbW9yZSBlcnJhdGEgaXRlbXMgdGhhbiB0
aGUgTUNQMjUxOEZELiBBbnlvbmUgdXNpbmcNCj4gdGhlIGVhcmxpZXIgY2hpcCBtaWdodCBiZQ0K
PiBzZWVpbmcgbW9yZSBwcm9ibGVtcyB0aGFuIHBlb3BsZSB1c2luZyB0aGUgTUNQMjUxOEZEIGFy
ZS4NClllcywgYXQgdGhpcyBwb2ludCBlc3BlY2lhbGx5IHdpdGggdGhlIGxvbmcgZGVsYXlzIGVy
cmF0dW0gb24gdGhlIE1DUDI1MTdGRCBhbmQgdGhlIHdheSB0aGF0IG1vc3QgU1BJIENvbnRyb2xs
ZXJzIHVuZGVyIExpbnV4IGJlaGF2ZSB0aGUgTUNQMjUxOEZEIGlzIHRoZSBtdWNoIGJldHRlciBj
aG9pY2UuIFRoZXkncmUgcGluIGNvbXBhdGlibGUgYW55d2F5IGFuZCBtb3N0bHkgU1cgY29tcGF0
aWJsZSAodGhhdCBpcyB0cnVlIHVubGVzcyB5b3Ugd2VyZSBpZ25vcmluZyB0aGluZ3MgbGlrZSBs
ZWF2aW5nIHJlc2VydmVkIGJpdHMgdW50b3VjaGVkIGV0Yy4pIFRoZSBNQ1AyNTE4RkQgaGFzIGhh
ZCB0aGUgc2VxdWVuY2UgZmllbGQgZXh0ZW5kZWQgYW5kIHRoZSBMUE1FTiBiaXQgYWRkZWQgYnV0
IHRoYXQncyBpdC4gU28gZm9yIDk5JSBvZiB0aGUgcGVvcGxlIHRoZXJlJ3MgcmVhbGx5IG5vIHJl
YXNvbiB0byBzdGlsbCB1c2UgdGhlIDE3RkQuDQoNClRob21hcw0K
